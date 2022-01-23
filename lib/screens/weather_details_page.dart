import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/card/card_info_item.dart';
import 'package:weather_app/components/card/primary_card.dart';
import 'package:weather_app/components/weather_details/hourly_info_widget.dart';
import 'package:weather_app/components/weather_details/main_weather_info.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/cubits/commons/log/log_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/cubits/weather/weather_details_cubit.dart';
import 'package:weather_app/data/enums_extensions/enums.dart';
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/data/models/weathers/api/response/weather_details_response.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class WeatherDetailsArg {
  final City? citySelected;
  final WeatherDetailsResponse? weatherDetailsResponse;

  const WeatherDetailsArg({this.citySelected, this.weatherDetailsResponse})
      : assert(citySelected != null || weatherDetailsResponse != null,
            'Either city or weather details response must be passed in');
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

  late String _cityName;

  late WeatherDetailsCubit _weatherDetailsCubit;

  @override
  void initState() {
    super.initState();

    _i18nService = getIt.get();

    final _args = widget.args;

    final _citySelected = _args.citySelected;
    final _weatherDetailsResponse = _args.weatherDetailsResponse;

    final _isResponseLoaded = _weatherDetailsResponse != null;

    _weatherDetailsCubit = WeatherDetailsCubit.initial(
      languageCubit: BlocProvider.of(context),
      state: _isResponseLoaded
          ? WeatherDetailsLoaded(weatherDetailsResponse: _weatherDetailsResponse)
          : const WeatherDetailsInitial(),
    );

    if (!_isResponseLoaded && _citySelected != null) {
      _weatherDetailsCubit.loadWeatherDetails(
        lat: _citySelected.lat,
        lng: _citySelected.lng,
      );
    }

    _cityName = _citySelected?.city ?? _weatherDetailsResponse!.timezone;

    final _logCubit = BlocProvider.of<LogCubit>(context);

    _logCubit.logEvent(
      actionType: ActionType.read,
      category: Category.weather,
      pageName: weatherDetailsPage,
      data: _citySelected?.city.toString() ?? _weatherDetailsResponse?.latLng,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _textTheme = themeState.themeData.textTheme;
        final _colorTheme = themeState.colorTheme;

        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(themeState.bgImg),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                bottom: false,
                child: BlocProvider(
                  create: (context) => _weatherDetailsCubit,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            Icons.arrow_back,
                            color: _colorTheme.onSurfaceColor,
                          ),
                        ),
                      ),
                      BlocBuilder<WeatherDetailsCubit, WeatherDetailsState>(
                        builder: (context, weatherDetailsState) {
                          if (weatherDetailsState is WeatherDetailsLoading) {
                            return Center(
                              child: Text(
                                _i18nService.translate(context, 'loading'),
                                style: _textTheme.bodyText2!.copyWith(color: _colorTheme.onSurfaceColor),
                              ),
                            );
                          }

                          if (weatherDetailsState is WeatherDetailsLoadFailed) {
                            return Center(
                              child: Text(
                                _i18nService.translate(context, 'weather_load_failed'),
                                style: _textTheme.bodyText2!.copyWith(color: _colorTheme.onSurfaceColor),
                              ),
                            );
                          }

                          final _weatherDetailsResponse = weatherDetailsState.weatherDetailsResponse;
                          final _current = _weatherDetailsResponse!.current;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              MainWeatherInfo(
                                city: _cityName,
                                iconName: _current.weather.first.icon,
                                currentTemp: _current.temp,
                                feelsLikeTemp: _current.feelsLike,
                              ),
                              _ExtraDetailSection(detailsResponse: _weatherDetailsResponse),
                              _ForeCastDetailSection(detailsResponse: _weatherDetailsResponse),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 100.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
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

    return Padding(
      padding: const EdgeInsets.only(top: spaceLarge),
      child: PrimaryCard(
        title: _summary.combineDesc,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _hourly
                .map(
                  (hour) => HourlyInfoWidget(hourly: hour),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _ForeCastDetailSection extends StatelessWidget {
  final I18nService _i18nService;

  final WeatherDetailsResponse detailsResponse;

  _ForeCastDetailSection({
    Key? key,
    required this.detailsResponse,
  })  : _i18nService = getIt.get(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _daily = detailsResponse.daily;

    return Padding(
      padding: const EdgeInsets.only(top: spaceLarge),
      child: PrimaryCard(
        title: _i18nService.translate(context, 'next_7_day_forecast'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _daily.getRange(1, _daily.length).map(
            (daily) {
              final _min = _i18nService.translate(
                context,
                'temperature',
                translationParams: {
                  'temperature': daily.temp.min.toString(),
                },
              );

              final _max = _i18nService.translate(
                context,
                'temperature',
                translationParams: {
                  'temperature': daily.temp.max.toString(),
                },
              );

              return CardInfoItem(
                label: DateFormat('dd MMM yyyy').format(daily.dateTime),
                info: '$_min - $_max',
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
