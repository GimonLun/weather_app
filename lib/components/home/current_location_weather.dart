import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/card/primary_card.dart';
import 'package:weather_app/components/weather_details/main_weather_info.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/commons/location/location_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class CurrentLocationWeather extends StatefulWidget {
  const CurrentLocationWeather({Key? key}) : super(key: key);

  @override
  _CurrentLocationWeatherState createState() => _CurrentLocationWeatherState();
}

class _CurrentLocationWeatherState extends State<CurrentLocationWeather> {
  late LocationCubit _locationCubit;
  late I18nService _i18nService;

  @override
  void initState() {
    super.initState();

    _i18nService = getIt.get();

    _locationCubit = BlocProvider.of(context);
    _locationCubit.getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _textTheme = themeState.themeData.textTheme;
        final _colorTheme = themeState.colorTheme;

        return Padding(
          padding: const EdgeInsets.only(top: spaceLarge),
          child: PrimaryCard(
            title: _i18nService.translate(context, 'current_location_weather'),
            child: BlocBuilder<LocationCubit, LocationState>(
              builder: (context, locationState) {
                final _subtitle2 = _textTheme.subtitle2!.copyWith(color: _colorTheme.onSurfaceColor);

                if (locationState is LocationLoading) {
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

                //TODO replace with proper value
                return MainWeatherInfo(
                  city: 'KL',
                  iconName: '04d',
                  currentTemp: 23.2,
                  feelsLikeTemp: 29.2,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
