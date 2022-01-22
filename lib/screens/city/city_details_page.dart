import 'package:flutter/material.dart';
import 'package:weather_app/data/models/city.dart';

class CityDetailsArg {
  final City citySelected;

  const CityDetailsArg({required this.citySelected});
}

class CityDetailsPage extends StatefulWidget {
  static const routeName = 'city_details';

  final CityDetailsArg args;

  const CityDetailsPage(this.args, {Key? key}) : super(key: key);

  @override
  _CityDetailsPageState createState() => _CityDetailsPageState();
}

class _CityDetailsPageState extends State<CityDetailsPage> {
  late City _citySelected;

  @override
  void initState() {
    super.initState();

    _citySelected = widget.args.citySelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _citySelected.city,
        ),
      ),
    );
  }
}
