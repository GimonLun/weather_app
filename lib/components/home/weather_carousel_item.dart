import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/components/card/primary_card.dart';
import 'package:weather_app/components/weather_details/main_weather_info.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/commons/location/location_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/cubits/weather/weather_details_cubit.dart';
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/screens/weather_details_page.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class WeatherCarouselItem extends StatefulWidget {
  final String title;
  final Widget? titleSuffix;
  final City? city;

  const WeatherCarouselItem({
    Key? key,
    this.city,
    required this.title,
    this.titleSuffix,
  }) : super(key: key);

  @override
  _WeatherCarouselItemState createState() => _WeatherCarouselItemState();
}

class _WeatherCarouselItemState extends State<WeatherCarouselItem> {
  late I18nService _i18nService;

  late LocationCubit _locationCubit;
  late WeatherDetailsCubit _weatherDetailsCubit;

  @override
  void initState() {
    super.initState();

    _i18nService = getIt.get();

    final _city = widget.city;

    _weatherDetailsCubit = WeatherDetailsCubit.initial(
      languageCubit: BlocProvider.of(context),
    );

    _locationCubit = BlocProvider.of(context);

    if (_city != null) {
      _weatherDetailsCubit.loadWeatherDetails(
        lat: _city.lat,
        lng: _city.lng,
      );
    } else if (_locationCubit.allPermissionEnabled && _locationCubit.state is LocationLoaded) {
      final _locationState = _locationCubit.state as LocationLoaded;
      final _locationData = _locationState.locationData!;

      _weatherDetailsCubit.loadWeatherDetails(
        lat: _locationData.latitude!,
        lng: _locationData.longitude!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, locationState) async {
        final _locationState = _locationCubit.state;

        if (_locationState is LocationLoaded && _locationState.locationData != null) {
          final _locationData = _locationState.locationData!;

          _weatherDetailsCubit.loadWeatherDetails(
            lat: _locationData.latitude!,
            lng: _locationData.longitude!,
          );
        }
      },
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          final _textTheme = themeState.themeData.textTheme;
          final _colorTheme = themeState.colorTheme;

          final _subtitle2 = _textTheme.subtitle2!.copyWith(color: _colorTheme.onSurfaceColor);

          return Padding(
            padding: const EdgeInsets.only(top: spaceLarge),
            child: PrimaryCard(
              margin: EdgeInsets.zero,
              title: widget.title,
              titleSuffix: widget.titleSuffix,
              child: BlocBuilder<WeatherDetailsCubit, WeatherDetailsState>(
                bloc: _weatherDetailsCubit,
                builder: (context, weatherDetailsState) {
                  final _isDetailsLoaded = weatherDetailsState is WeatherDetailsLoaded;
                  final _weatherDetailsResponse = weatherDetailsState.weatherDetailsResponse;

                  return GestureDetector(
                    onTap: _isDetailsLoaded
                        ? () {
                            Navigator.of(context).pushNamed(
                              WeatherDetailsPage.routeName,
                              arguments: WeatherDetailsArg(
                                weatherDetailsResponse: _weatherDetailsResponse,
                                citySelected: widget.city,
                              ),
                            );
                          }
                        : null,
                    child: BlocBuilder<LocationCubit, LocationState>(
                      builder: (context, locationState) {
                        if (_isDetailsLoaded) {
                          final _current = _weatherDetailsResponse!.current;
                          final _weather = _current.weather;

                          return MainWeatherInfo(
                            containerHeight: homePageCardContentHeight,
                            city: _weather.first.combineDesc,
                            iconName: _weather.first.icon,
                            currentTemp: _current.temp,
                            feelsLikeTemp: _current.feelsLike,
                          );
                        }

                        if (weatherDetailsState is WeatherDetailsLoadFailed) {
                          return Text(
                            _i18nService.translate(
                              context,
                              'weather_load_failed',
                            ),
                            style: _subtitle2,
                          );
                        }

                        if (locationState is LocationLoading || weatherDetailsState is WeatherDetailsLoading) {
                          return Text(
                            _i18nService.translate(
                              context,
                              'loading',
                            ),
                            style: _subtitle2,
                          );
                        }

                        if (locationState is LocationError) {
                          var _showOpenSettingsButton = false;

                          final _locationPermission = locationState.permissionStatus;

                          _showOpenSettingsButton = _locationPermission == PermissionStatus.denied ||
                              _locationPermission == PermissionStatus.permanentlyDenied;

                          return Column(
                            children: [
                              Text(
                                locationState.errorNeedTranslate
                                    ? _i18nService.translate(
                                        context,
                                        locationState.errorMsg,
                                      )
                                    : locationState.errorMsg,
                                style: _subtitle2,
                              ),
                              if (_showOpenSettingsButton)
                                TextButton(
                                  child: Text(
                                    _i18nService.translate(
                                      context,
                                      'permissions.open_app_settings',
                                    ),
                                  ),
                                  onPressed: () async {
                                    await openAppSettings();
                                  },
                                )
                            ],
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
