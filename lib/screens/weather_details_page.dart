import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/cubits/weather/weather_details_cubit.dart';
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class WeatherDetailsArg {
  final City citySelected;

  const WeatherDetailsArg({required this.citySelected});
}

class WeatherDetailsPage extends StatefulWidget {
  static const routeName = 'weather_details';

  final WeatherDetailsArg args;

  const WeatherDetailsPage(this.args, {Key? key}) : super(key: key);

  @override
  _WeatherDetailsPageState createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  late City _citySelected;

  late WeatherDetailsCubit _weatherDetailsCubit;

  @override
  void initState() {
    super.initState();

    _citySelected = widget.args.citySelected;

    _weatherDetailsCubit = WeatherDetailsCubit.initial(citySelected: _citySelected);
    _weatherDetailsCubit.loadWeatherDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => _weatherDetailsCubit,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
                _CityWeatherDetails(
                  citySelected: _citySelected,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CityWeatherDetails extends StatelessWidget {
  final City citySelected;
  final I18nService _i18nService;

  _CityWeatherDetails({
    Key? key,
    required this.citySelected,
  })  : _i18nService = getIt.get(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _textTheme = themeState.themeData.textTheme;

        return BlocBuilder<WeatherDetailsCubit, WeatherDetailsState>(
          builder: (context, weatherDetailsState) {
            if (weatherDetailsState is WeatherDetailsLoading) {
              return Center(
                child: Text(_i18nService.translate(context, 'loading')),
              );
            }

            if (weatherDetailsState is WeatherDetailsLoadFailed) {
              return Center(
                child: Text(_i18nService.translate(context, 'weather_load_failed')),
              );
            }

            final _weatherDetailsResponse = weatherDetailsState.weatherDetailsResponse;
            final _main = _weatherDetailsResponse!.main;

            return Container(
              padding: const EdgeInsets.symmetric(vertical: spaceLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    citySelected.city,
                    style: _textTheme.headline3,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: spaceMid),
                    child: Text(
                      _i18nService.translate(context, 'temperature', translationParams: {
                        'temperature': _main.temp.toString(),
                      }),
                      style: _textTheme.headline1,
                    ),
                  ),
                  Text(
                    _i18nService.translate(context, 'feel_like', translationParams: {
                      'temperature': _main.feelsLike.toString(),
                    }),
                    style: _textTheme.subtitle2,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
