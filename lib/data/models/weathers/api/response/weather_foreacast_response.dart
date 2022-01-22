import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/models/weathers/weather.dart';

part 'weather_foreacast_response.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherForecastResponse extends Equatable {
  final String message;
  final String cod;

  @JsonKey(name: 'list')
  final List<Weather> weathers;

  const WeatherForecastResponse({
    required this.message,
    required this.cod,
    required this.weathers,
  });

  factory WeatherForecastResponse.fromJson(Map<String, dynamic> json) => _$WeatherForecastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastResponseToJson(this);

  @override
  List<Object> get props => [message, cod, weathers];
}
