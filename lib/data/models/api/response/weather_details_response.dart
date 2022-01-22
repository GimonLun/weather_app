import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/models/weathers/weather.dart';

part 'weather_details_response.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherDetailsResponse extends Equatable {
  final String message;
  final String cod;

  @JsonKey(name: 'list')
  final List<Weather> weathers;

  const WeatherDetailsResponse({
    required this.message,
    required this.cod,
    required this.weathers,
  });

  factory WeatherDetailsResponse.fromJson(Map<String, dynamic> json) => _$WeatherDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDetailsResponseToJson(this);

  @override
  List<Object> get props => [message, cod, weathers];
}
