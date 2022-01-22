import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/screens/weather_details_page.dart';
import 'package:weather_app/screens/city/city_list_page.dart';

class AppRouter {
  final _allRoutes = <String, Function(RouteSettings settings)>{
    CityListPage.routeName: (_) => const CityListPage(),
    HomePage.routeName: (_) => const HomePage(),
    WeatherDetailsPage.routeName: (settings) => WeatherDetailsPage(settings.arguments as WeatherDetailsArg),
  };

  Route onGenerateRoute(RouteSettings settings) {
    final _builder = _allRoutes[settings.name!];

    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => _builder!(settings),
    );
  }
}
