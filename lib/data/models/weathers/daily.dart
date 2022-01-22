import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/models/weathers/summary.dart';
import 'package:weather_app/data/models/weathers/temp.dart';
import 'package:weather_app/utils/convert_helper.dart';

part 'daily.g.dart';

@JsonSerializable(explicitToJson: true)
class Daily extends Equatable {
  @JsonKey(name: 'dt', fromJson: intToDateTime, toJson: dateTimeToint)
  final DateTime dateTime;

  final List<Summary> weather;

  final Temp temp;

  const Daily({
    required this.dateTime,
    required this.weather,
    required this.temp,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);

  Map<String, dynamic> toJson() => _$DailyToJson(this);

  @override
  List<Object> get props => [
        dateTime,
        weather,
        temp,
      ];
}
