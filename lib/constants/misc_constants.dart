import 'package:weather_app/data/enums_extensions/enums.dart';

const Language defaultLanguage = Language.en;

const String openWeatherBaseUrl = 'https://api.openweathermap.org/data/2.5/';

/// TODO remove the api key and keep in .env in real life
/// In real life, we will set all api key and credential value into .env.
/// However, since this is very simple test project so setup env support is overkills so i keep it here for now
const String openWeatherApiKey = 'ad03cb447ee4689f565d1faa4263a66';
