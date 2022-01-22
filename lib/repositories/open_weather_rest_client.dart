import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/constants/misc_constants.dart';

part 'open_weather_rest_client.g.dart';

@RestApi(baseUrl: openWeatherBaseUrl)
abstract class OpenWeatherRestClient {
  factory OpenWeatherRestClient(Dio dio, {String baseUrl}) = _OpenWeatherRestClient;
}
