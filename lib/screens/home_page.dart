import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/card/card_info_item.dart';
import 'package:weather_app/components/card/primary_card.dart';
import 'package:weather_app/components/home/add_city_card.dart';
import 'package:weather_app/components/home/weather_carousel_item.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/city/city_list_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/cubits/home/home_cubit.dart';
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
  late HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();

    _homeCubit = HomeCubit.initial();
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
                  _CardSection(homeCubit: _homeCubit),
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

class _CardSection extends StatelessWidget {
  final HomeCubit homeCubit;
  final I18nService _i18nService;

  _CardSection({
    Key? key,
    required this.homeCubit,
  })  : _i18nService = getIt.get(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, homeState) {
        final _cityList = homeState.cityList;

        return CarouselSlider.builder(
          itemBuilder: (context, index, realIndex) => LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: spaceMid),
                child: Builder(
                  builder: (context) {
                    if (index == 0) {
                      return WeatherCarouselItem(title: _i18nService.translate(context, 'current_location_weather'));
                    }

                    if (index == _cityList.length + 1) {
                      return AddCityCard(homeCubit: homeCubit);
                    }

                    final _city = _cityList.elementAt(index - 1);

                    return WeatherCarouselItem(
                      title: _city.city,
                      city: _city,
                    );
                  },
                ),
              );
            },
          ),
          itemCount: _cityList.length + 2,
          options: CarouselOptions(
            height: homePageCarousellHeight,
            initialPage: 0,
            viewportFraction: 0.9,
            enableInfiniteScroll: false,
            reverse: false,
            enlargeCenterPage: false,
            scrollDirection: Axis.horizontal,
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
