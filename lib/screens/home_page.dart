import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/card/card_info_item.dart';
import 'package:weather_app/components/card/primary_card.dart';
import 'package:weather_app/components/weather_details/main_weather_info.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/city/city_list_cubit.dart';
import 'package:weather_app/cubits/commons/location/location_cubit.dart';
import 'package:weather_app/cubits/commons/location/location_state.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/screens/weather_details_page.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LocationCubit _locationCubit;

  @override
  void initState() {
    super.initState();

    _locationCubit = BlocProvider.of(context);
    _locationCubit.getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          final _colorTheme = themeState.colorTheme;

          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        color: _colorTheme.onSurfaceColor,
                      ),
                    ),
                  ),
                  _CurrentLocationWeather(),
                  _CityListSection(),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CurrentLocationWeather extends StatelessWidget {
  final I18nService _i18nService;

  _CurrentLocationWeather({
    Key? key,
  })  : _i18nService = getIt.get(),
        super(key: key);

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

class _CityListSection extends StatelessWidget {
  final I18nService _i18nService;

  _CityListSection({
    Key? key,
  })  : _i18nService = getIt.get(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _textTheme = themeState.themeData.textTheme;
        final _colorTheme = themeState.colorTheme;

        return Padding(
          padding: const EdgeInsets.only(top: spaceLarge),
          child: PrimaryCard(
            title: _i18nService.translate(context, 'view_temperature_by_city'),
            child: BlocBuilder<CityListCubit, CityListState>(
              builder: (context, cityListState) {
                if (cityListState is CityListLoaded) {
                  final _cityList = cityListState.cityList;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _cityList.map(
                      (city) {
                        return CardInfoItem(
                          label: city.city,
                          showArrow: true,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              WeatherDetailsPage.routeName,
                              arguments: WeatherDetailsArg(citySelected: city),
                            );
                          },
                        );
                      },
                    ).toList(),
                  );
                }

                return Text(
                  _i18nService.translate(
                    context,
                    'loading',
                  ),
                  style: _textTheme.subtitle2!.copyWith(color: _colorTheme.onSurfaceColor),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
