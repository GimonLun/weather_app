import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/cubits/weather/weather_details_cubit.dart';
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/data/models/weathers/api/response/weather_details_response.dart';
import 'package:weather_app/data/models/weathers/hourly.dart';
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
  late I18nService _i18nService;

  late City _citySelected;

  late WeatherDetailsCubit _weatherDetailsCubit;

  @override
  void initState() {
    super.initState();

    _i18nService = getIt.get();

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
                BlocBuilder<WeatherDetailsCubit, WeatherDetailsState>(
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
                    final _current = _weatherDetailsResponse!.current;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _CityWeatherDetails(
                          current: _current,
                          citySelected: _citySelected,
                        ),
                        _ExtraDetailSection(detailsResponse: _weatherDetailsResponse)
                      ],
                    );
                  },
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
  final I18nService _i18nService;
  final Hourly current;
  final City citySelected;

  _CityWeatherDetails({
    Key? key,
    required this.current,
    required this.citySelected,
  })  : _i18nService = getIt.get(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _textTheme = themeState.themeData.textTheme;

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
                    'temperature': current.temp.toString(),
                  }),
                  style: _textTheme.headline1,
                ),
              ),
              Text(
                _i18nService.translate(context, 'feel_like', translationParams: {
                  'temperature': current.feelsLike.toString(),
                }),
                style: _textTheme.subtitle2,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ExtraDetailSection extends StatelessWidget {
  final WeatherDetailsResponse detailsResponse;

  const _ExtraDetailSection({
    Key? key,
    required this.detailsResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _summary = detailsResponse.current.weather.first;
    final _hourly = detailsResponse.hourly;

    return Card(
      margin: const EdgeInsets.fromLTRB(screenBoundingSpace, screenBoundingSpace, screenBoundingSpace, 0.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spaceLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: spaceXMid),
              child: Text(_summary.combineDesc),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: spaceXMid),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _hourly
                      .map(
                        (hour) => _HourTemp(hourly: hour),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HourTemp extends StatelessWidget {
  final I18nService _i18nService;

  final Hourly hourly;

  _HourTemp({
    Key? key,
    required this.hourly,
  })  : _i18nService = getIt.get(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: spaceXMid),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(DateFormat('hh:mma').format(hourly.dateTime)),
          Image.network(
            'http://openweathermap.org/img/w/${hourly.weather.first.icon}.png',
          ),
          Text(
            _i18nService.translate(
              context,
              'temperature',
              translationParams: {
                'temperature': hourly.temp.toString(),
              },
            ),
          ),
        ],
      ),
    );
  }
}
