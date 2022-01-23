import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/utils/convert_helper.dart';

part 'city.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class City extends Equatable {
  @HiveField(0)
  final String city;

  @HiveField(1)
  @JsonKey(fromJson: stringToDouble, toJson: doubleToString)
  final double lat;

  @HiveField(2)
  @JsonKey(fromJson: stringToDouble, toJson: doubleToString)
  final double lng;

  @HiveField(3)
  final int index;

  const City({
    required this.city,
    required this.lat,
    required this.lng,
    this.index = 0,
  });

  City copyWith({
    String? city,
    double? lat,
    double? lng,
    int? index,
  }) {
    return City(city: city ?? this.city, lat: lat ?? this.lat, lng: lng ?? this.lng, index: index ?? this.index);
  }

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  @override
  List<Object> get props => [city, lat, lng, index];
}
