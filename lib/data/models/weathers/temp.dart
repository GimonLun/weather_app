import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'temp.g.dart';

@JsonSerializable(explicitToJson: true)
class Temp extends Equatable {
  final double min, max;

  const Temp({
    required this.min,
    required this.max,
  });

  factory Temp.fromJson(Map<String, dynamic> json) => _$TempFromJson(json);

  Map<String, dynamic> toJson() => _$TempToJson(this);

  @override
  List<Object> get props => [
        min,
        max,
      ];
}
