import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'package:weather_app/service_locator.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final Location _location;

  bool isFirstTimeRequest;

  LocationCubit._({
    LocationState? state,
    this.isFirstTimeRequest = true,
  })  : _location = getIt.isRegistered<Location>() ? getIt.get<Location>() : Location(),
        super(state ?? const LocationInitial());

  // You can mock the state by simply passing it in here
  factory LocationCubit.initial({LocationState? state}) {
    //the case of is register only happen when you mock the cubit in test case
    if (getIt.isRegistered<LocationCubit>()) {
      return getIt.get<LocationCubit>();
    }

    return LocationCubit._(state: state);
  }

  Future<bool> get _serviceEnabled async => await _location.serviceEnabled();

  Future<bool> get _permissionGranted async => await _location.hasPermission() == PermissionStatus.granted;

  bool get allPermissionEnabled => state.serviceEnabled && state.permissionGranted;

  Future<void> getUserLocation({bool refresh = false}) async {
    if (!refresh && !isFirstTimeRequest) return;

    isFirstTimeRequest = false;

    emit(
      LocationLoading(
        serviceEnabled: state.serviceEnabled,
        permissionGranted: state.permissionGranted,
        locationData: state.locationData,
      ),
    );

    final locationServiceEnabled = await _checkAndRequestLocationService();
    if (!locationServiceEnabled) {
      emit(
        LocationError(
          serviceEnabled: locationServiceEnabled,
          permissionGranted: state.permissionGranted,
          locationData: state.locationData,
          errorMsg: 'location_service_disabled_error',
        ),
      );

      return;
    }

    final permissionGranted = await _checkAndRequestLocationPermission();
    if (!permissionGranted) {
      final _updatePermissionStatus = await permission_handler.Permission.location.status;

      emit(
        LocationError(
          serviceEnabled: state.serviceEnabled,
          permissionGranted: permissionGranted,
          locationData: state.locationData,
          errorMsg: 'permissions.location_denied_description',
          permissionStatus: _updatePermissionStatus,
        ),
      );

      return;
    }

    try {
      final _locationData = await _location.getLocation();

      emit(
        LocationLoaded(
          serviceEnabled: locationServiceEnabled,
          permissionGranted: permissionGranted,
          locationData: _locationData,
        ),
      );
    } catch (e) {
      emit(
        LocationError(
          serviceEnabled: locationServiceEnabled,
          permissionGranted: permissionGranted,
          locationData: state.locationData,
          errorMsg: e.toString(),
          errorNeedTranslate: false,
        ),
      );
    }
  }

  Future<void> checkAndUpdatePermissionStatus() async {
    emit(
      LocationPermissionUpdated(
        serviceEnabled: await _serviceEnabled,
        permissionGranted: await _permissionGranted,
        locationData: !allPermissionEnabled ? null : state.locationData,
      ),
    );
  }

  Future<bool> _checkAndRequestLocationPermission() async {
    if (await _permissionGranted) {
      return true;
    }

    return await _location.requestPermission() == PermissionStatus.granted;
  }

  Future<bool> _checkAndRequestLocationService() async {
    if (await _serviceEnabled) {
      return true;
    }

    return await _location.requestService();
  }
}
