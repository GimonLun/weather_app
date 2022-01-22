import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'winds.g.dart';

@JsonSerializable(explicitToJson: true)
class Winds extends Equatable {
  final double speed;
  final double? gust;

  final int deg;

  const Winds({
    required this.speed,
    required this.gust,
    required this.deg,
  });

  factory Winds.fromJson(Map<String, dynamic> json) => _$WindsFromJson(json);

  Map<String, dynamic> toJson() => _$WindsToJson(this);

  @override
  List<Object> get props => [
        speed,
        deg,
      ];
}
