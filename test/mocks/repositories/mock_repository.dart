import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/data/models/weathers/api/response/weather_details_response.dart';
import 'package:weather_app/data/models/weathers/daily.dart';
import 'package:weather_app/data/models/weathers/hourly.dart';
import 'package:weather_app/data/models/weathers/summary.dart';
import 'package:weather_app/data/models/weathers/temp.dart';
import 'package:weather_app/repositories/open_weather_rest_client.dart';

import 'mock_repository.mocks.dart';

@GenerateMocks([
  OpenWeatherRestClient,
])
void main() {}

MockOpenWeatherRestClient mockOpenWeatherRestClient({WeatherDetailsResponse? response, Exception? exception}) {
  final _client = MockOpenWeatherRestClient();

  if (exception != null) {
    when(_client.getWeatherByCoordinates(
      any,
      any,
      appid: anyNamed('appid'),
      lang: anyNamed('lang'),
      units: anyNamed('units'),
      exclude: anyNamed('exclude'),
    )).thenThrow(exception);
  } else {
    when(_client.getWeatherByCoordinates(
      any,
      any,
      appid: anyNamed('appid'),
      lang: anyNamed('lang'),
      units: anyNamed('units'),
      exclude: anyNamed('exclude'),
    )).thenAnswer(
      (_) => Future.value(response ?? buildWeatherDetailsResponseFromTemplate()),
    );
  }

  return _client;
}

WeatherDetailsResponse buildWeatherDetailsResponseFromTemplate({
  String timezone = 'Asia/KL',
  double lat = 24.4,
  double lng = 23.3,
  Hourly? current,
  List<Hourly>? hourly,
  List<Daily>? daily,
}) {
  return WeatherDetailsResponse(
    timezone: timezone,
    lat: lat,
    lng: lng,
    current: current ?? buildHourlyFromTemplate(),
    hourly: hourly ??
        [
          buildHourlyFromTemplate(),
          buildHourlyFromTemplate(),
          buildHourlyFromTemplate(),
          buildHourlyFromTemplate(),
        ],
    daily: daily ??
        [
          buildDailyFromTemplate(),
          buildDailyFromTemplate(),
          buildDailyFromTemplate(),
          buildDailyFromTemplate(),
          buildDailyFromTemplate(),
        ],
  );
}

Hourly buildHourlyFromTemplate(
    {DateTime? dateTime, List<Summary> weather = const [], double temp = 24.4, double feelsLike = 23.3}) {
  return Hourly(
    dateTime: dateTime ?? DateTime.now(),
    weather: weather,
    temp: temp,
    feelsLike: feelsLike,
  );
}

Daily buildDailyFromTemplate({DateTime? dateTime, List<Summary> weather = const [], Temp? temp}) {
  return Daily(
    dateTime: dateTime ?? DateTime.now(),
    weather: weather,
    temp: temp ?? buildTempFromTemplate(),
  );
}

Temp buildTempFromTemplate({double min = 19.4, double max = 23.3}) {
  return Temp(
    min: min,
    max: max,
  );
}
