import 'package:flutter/material.dart';
import 'package:weather_app/screens/city/city_details_page.dart';
import 'package:weather_app/screens/city/city_list_page.dart';

class AppRouter {
  final _allRoutes = <String, Function(RouteSettings settings)>{
    CityListPage.routeName: (_) => const CityListPage(),
    CityDetailsPage.routeName: (settings) => CityDetailsPage(settings.arguments as CityDetailsArg),
  };

  Route onGenerateRoute(RouteSettings settings) {
    final _builder = _allRoutes[settings.name!];

    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => _builder!(settings),
    );
  }
}
