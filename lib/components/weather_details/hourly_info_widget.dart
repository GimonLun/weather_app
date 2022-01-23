import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/data/models/weathers/hourly.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class HourlyInfoWidget extends StatelessWidget {
  final I18nService _i18nService;

  final Hourly hourly;

  HourlyInfoWidget({
    Key? key,
    required this.hourly,
  })  : _i18nService = getIt.get(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _textTheme = themeState.themeData.textTheme;
        final _colorTheme = themeState.colorTheme;

        return Padding(
          padding: const EdgeInsets.only(right: spaceXMid),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('hh:mma').format(hourly.dateTime),
                style: _textTheme.caption!.copyWith(
                  color: _colorTheme.onSurfaceColor,
                ),
              ),
              Image.network(
                '$openWeatherIconBaseUrl${hourly.weather.first.icon}.png',
              ),
              Text(
                _i18nService.translate(
                  context,
                  'temperature',
                  translationParams: {
                    'temperature': hourly.temp.toString(),
                  },
                ),
                style: _textTheme.caption!.copyWith(
                  color: _colorTheme.onSurfaceColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
