import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/card/primary_card.dart';
import 'package:weather_app/components/weather_details/main_weather_info.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/commons/location/location_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/cubits/weather/weather_details_cubit.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class CurrentLocationWeather extends StatefulWidget {
  const CurrentLocationWeather({Key? key}) : super(key: key);

  @override
  _CurrentLocationWeatherState createState() => _CurrentLocationWeatherState();
}

class _CurrentLocationWeatherState extends State<CurrentLocationWeather> {
  late I18nService _i18nService;

  late LocationCubit _locationCubit;
  late WeatherDetailsCubit _weatherDetailsCubit;

  @override
  void initState() {
    super.initState();

    _i18nService = getIt.get();

    _locationCubit = BlocProvider.of(context);
    _locationCubit.getUserLocation();

    _weatherDetailsCubit = WeatherDetailsCubit.initial();
    if (_locationCubit.allPermissionEnabled && _locationCubit.state is LocationLoaded) {
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
      listener: (context, locationState) {
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
              title: _i18nService.translate(context, 'current_location_weather'),
              child: BlocBuilder<LocationCubit, LocationState>(
                builder: (context, locationState) {
                  return BlocBuilder<WeatherDetailsCubit, WeatherDetailsState>(
                    bloc: _weatherDetailsCubit,
                    builder: (context, weatherDetailsState) {
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
                        return Text(
                          locationState.errorNeedTranslate
                              ? _i18nService.translate(
                                  context,
                                  locationState.errorMsg,
                                )
                              : locationState.errorMsg,
                          style: _subtitle2,
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

                      if (weatherDetailsState is WeatherDetailsLoaded) {
                        final _weatherDetailsResponse = weatherDetailsState.weatherDetailsResponse;
                        final _current = _weatherDetailsResponse!.current;

                        final _locationData = locationState.locationData!;

                        return Column(
                          children: [
                            Text(
                              '${_locationData.latitude}, ${_locationData.longitude}',
                              style: _subtitle2,
                            ),
                            MainWeatherInfo(
                              city: _weatherDetailsResponse.timezone,
                              iconName: _current.weather.first.icon,
                              currentTemp: _current.temp,
                              feelsLikeTemp: _current.feelsLike,
                            ),
                          ],
                        );
                      }

                      return const SizedBox.shrink();
                    },
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
