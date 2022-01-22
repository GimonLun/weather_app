import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable(explicitToJson: true)
class City extends Equatable {
  final String city;

  @JsonKey(fromJson: _stringToDouble, toJson: _doubleToString)
  final double lat;

  @JsonKey(fromJson: _stringToDouble, toJson: _doubleToString)
  final double lng;

  const City({
    required this.city,
    required this.lat,
    required this.lng,
  });

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);

  @override
  List<Object> get props => [city, lat, lng];
}

String _doubleToString(double value) => value.toString();
double _stringToDouble(String value) => double.tryParse(value) ?? 0.0;
