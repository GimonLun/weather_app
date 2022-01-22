import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/models/weathers/main.dart';
import 'package:weather_app/data/models/weathers/summary.dart';
import 'package:weather_app/data/models/weathers/winds.dart';

part 'weather.g.dart';

@JsonSerializable(explicitToJson: true)
class Weather extends Equatable {
  final Main main;

  final List<Summary> weather;

  final Winds wind;

  @JsonKey(name: 'dt_txt')
  final String dateTime;

  const Weather({
    required this.main,
    required this.weather,
    required this.wind,
    required this.dateTime,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  List<Object> get props => [
        main,
        weather,
        wind,
        dateTime,
      ];
}
