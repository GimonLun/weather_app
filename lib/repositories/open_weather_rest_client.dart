import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/data/models/weathers/api/response/weather_details_response.dart';
import 'package:weather_app/data/models/weathers/api/response/weather_foreacast_response.dart';

part 'open_weather_rest_client.g.dart';

@RestApi(baseUrl: openWeatherBaseUrl)
abstract class OpenWeatherRestClient {
  factory OpenWeatherRestClient(Dio dio, {String baseUrl}) = _OpenWeatherRestClient;

  @GET("/forecast")
  Future<WeatherForecastResponse> getWeatherByCoordinates(
    @Query("lon") double lon,
    @Query("lat") double lat,
    @Query("appid") String appid, {
    @Query("lang") String lang = 'en_GB',
    @Query("units") String units = 'metric',
  });

  @GET("/weather")
  Future<WeatherDetailsResponse> getCurrentWeatherByCoordinates(
    @Query("lon") double lon,
    @Query("lat") double lat,
    @Query("appid") String appid, {
    @Query("lang") String lang = 'en_GB',
    @Query("units") String units = 'metric',
  });
}
