import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class MainWeatherInfo extends StatelessWidget {
  final String city, iconName;
  final double currentTemp, feelsLikeTemp;
  final I18nService _i18nService;
  final double? containerHeight;

  MainWeatherInfo({
    Key? key,
    required this.city,
    required this.iconName,
    required this.currentTemp,
    required this.feelsLikeTemp,
    this.containerHeight,
  })  : _i18nService = getIt.get(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _textTheme = themeState.themeData.textTheme;
        final _colorTheme = themeState.colorTheme;

        return SizedBox(
          height: containerHeight,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: spaceMid),
                      child: Image.network(
                        '$openWeatherIconBaseUrl$iconName.png',
                      ),
                    ),
                    Text(
                      city,
                      style: _textTheme.headline3!.copyWith(
                        color: _colorTheme.onSurfaceColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: spaceMid),
                  child: Text(
                    _i18nService.translate(context, 'temperature', translationParams: {
                      'temperature': currentTemp.toString(),
                    }),
                    style: _textTheme.headline1!.copyWith(
                      color: _colorTheme.onSurfaceColor,
                    ),
                  ),
                ),
                Text(
                  _i18nService.translate(context, 'feel_like', translationParams: {
                    'temperature': feelsLikeTemp.toString(),
                  }),
                  style: _textTheme.subtitle2!.copyWith(
                    color: _colorTheme.onSurfaceColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
