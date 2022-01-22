import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/city/city_list_cubit.dart';
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
  late I18nService _i18nService;

  @override
  void initState() {
    super.initState();

    _i18nService = getIt.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          final _textTheme = themeState.themeData.textTheme;

          return BlocBuilder<CityListCubit, CityListState>(
            builder: (context, cityListState) {
              if (cityListState is CityListLoading) {
                return Center(
                  child: Text(_i18nService.translate(context, 'loading')),
                );
              }

              final _cityList = cityListState.cityList;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: screenBoundingSpace),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: spaceLarge,
                  crossAxisSpacing: screenBoundingSpace,
                  itemBuilder: (context, index) {
                    final _item = _cityList.elementAt(index);

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          WeatherDetailsPage.routeName,
                          arguments: WeatherDetailsArg(citySelected: _item),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(spaceXLarge),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _item.city,
                                style: _textTheme.headline3!.copyWith(fontWeight: FontWeight.normal),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: spaceMid),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lat: ${_item.lat.toString()}',
                                      style: _textTheme.subtitle2!.copyWith(fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      'Lng: ${_item.lng.toString()}',
                                      style: _textTheme.subtitle2!.copyWith(fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _cityList.length,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
