import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/data/models/weathers/daily.dart';
import 'package:weather_app/data/models/weathers/hourly.dart';

part 'weather_details_response.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherDetailsResponse extends Equatable {
  final String timezone;

  final double lat;

  @JsonKey(name: 'lon')
  final double lng;

  final Hourly current;
  final List<Hourly> hourly;
  final List<Daily> daily;

  const WeatherDetailsResponse({
    required this.timezone,
    required this.lat,
    required this.lng,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  String get latLng => 'Lat: ${lat.toString()}, Lng: ${lng.toString()}';

  factory WeatherDetailsResponse.fromJson(Map<String, dynamic> json) => _$WeatherDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDetailsResponseToJson(this);

  @override
  List<Object> get props => [
        timezone,
        lat,
        lng,
        current,
        hourly,
        daily,
      ];
}
