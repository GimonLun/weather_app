import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_list_page.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/screens/log_list_page.dart';
import 'package:weather_app/screens/weather_details_page.dart';

class AppRouter {
  final _allRoutes = <String, Function(RouteSettings settings)>{
    CityListPage.routeName: (_) => const CityListPage(),
    HomePage.routeName: (_) => const HomePage(),
    LogListPage.routeName: (_) => const LogListPage(),
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
