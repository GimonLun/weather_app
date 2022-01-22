import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/models/weathers/main.dart';
import 'package:weather_app/data/models/weathers/summary.dart';
import 'package:weather_app/data/models/weathers/winds.dart';

part 'weather_details_response.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherDetailsResponse extends Equatable {
  final int cod;

  final Main main;
  final List<Summary> weather;
  final Winds wind;

  const WeatherDetailsResponse({
    required this.cod,
    required this.main,
    required this.weather,
    required this.wind,
  });

  factory WeatherDetailsResponse.fromJson(Map<String, dynamic> json) => _$WeatherDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDetailsResponseToJson(this);

  @override
  List<Object> get props => [
        cod,
        main,
        weather,
        wind,
      ];
}
