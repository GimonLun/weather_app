import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/models/weathers/summary.dart';
import 'package:weather_app/utils/convert_helper.dart';

part 'hourly.g.dart';

@JsonSerializable(explicitToJson: true)
class Hourly extends Equatable {
  @JsonKey(name: 'dt', fromJson: intToDateTime, toJson: dateTimeToint)
  final DateTime dateTime;

  final List<Summary> weather;

  final double temp;

  @JsonKey(name: 'feels_like')
  final double feelsLike;

  const Hourly({
    required this.dateTime,
    required this.weather,
    required this.temp,
    required this.feelsLike,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyToJson(this);

  @override
  List<Object> get props => [
        dateTime,
        weather,
        temp,
        feelsLike,
      ];
}
