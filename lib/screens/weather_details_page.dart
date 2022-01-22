import 'package:flutter/material.dart';
import 'package:weather_app/cubits/weather/weather_details_cubit.dart';
import 'package:weather_app/data/models/city.dart';

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
  late City _citySelected;

  late WeatherDetailsCubit _weatherDetailsCubit;

  @override
  void initState() {
    super.initState();

    _citySelected = widget.args.citySelected;

    _weatherDetailsCubit = WeatherDetailsCubit.initial(citySelected: _citySelected);
    _weatherDetailsCubit.loadWeatherDetails();
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
