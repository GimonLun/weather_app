part of 'location_cubit.dart';

abstract class LocationState extends Equatable {
  final bool serviceEnabled, permissionGranted;
  final LocationData? locationData;

  const LocationState({
    required this.serviceEnabled,
    required this.permissionGranted,
    required this.locationData,
  });

  @override
  List<Object?> get props => [
        serviceEnabled,
        permissionGranted,
        locationData,
      ];
}

class LocationInitial extends LocationState {
  const LocationInitial()
      : super(
          serviceEnabled: false,
          permissionGranted: false,
          locationData: null,
        );

  @override
  List<Object?> get props => super.props..addAll([]);
}

class LocationLoading extends LocationState {
  const LocationLoading({
    required bool serviceEnabled,
    required bool permissionGranted,
    required LocationData? locationData,
  }) : super(
          serviceEnabled: serviceEnabled,
          permissionGranted: permissionGranted,
          locationData: locationData,
        );

  @override
  List<Object?> get props => super.props..addAll([]);
}

class LocationLoaded extends LocationState {
  const LocationLoaded({
    required bool serviceEnabled,
    required bool permissionGranted,
    required LocationData locationData,
  }) : super(
          serviceEnabled: serviceEnabled,
          permissionGranted: permissionGranted,
          locationData: locationData,
        );

  @override
  List<Object?> get props => super.props..addAll([]);
}

class LocationError extends LocationState {
  final String errorMsg;
  final bool errorNeedTranslate;

  const LocationError({
    required bool serviceEnabled,
    required bool permissionGranted,
    required LocationData? locationData,
    required this.errorMsg,
    this.errorNeedTranslate = true,
  }) : super(
          serviceEnabled: serviceEnabled,
          permissionGranted: permissionGranted,
          locationData: locationData,
        );

  @override
  List<Object?> get props => super.props..addAll([errorMsg, errorNeedTranslate]);
}

class LocationPermissionUpdated extends LocationState {
  const LocationPermissionUpdated({
    required bool serviceEnabled,
    required bool permissionGranted,
    required LocationData? locationData,
  }) : super(
          serviceEnabled: serviceEnabled,
          permissionGranted: permissionGranted,
          locationData: locationData,
        );

  @override
  List<Object?> get props => super.props..addAll([]);
}
