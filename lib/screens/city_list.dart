import 'package:flutter/material.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class CityList extends StatefulWidget {
  const CityList({Key? key}) : super(key: key);

  @override
  _CityListState createState() => _CityListState();
}

class _CityListState extends State<CityList> {
  late I18nService _i18nService;

  @override
  void initState() {
    super.initState();

    _i18nService = getIt.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _i18nService.translate(context, 'city_list_title'),
        ),
      ),
      body: const Center(
        child: Text('empty list now'),
      ),
    );
  }
}
