import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary.g.dart';

@JsonSerializable(explicitToJson: true)
class Summary extends Equatable {
  final String main, description, icon;

  const Summary({
    required this.main,
    required this.description,
    required this.icon,
  });

  String get combineDesc => '$main, $description';

  factory Summary.fromJson(Map<String, dynamic> json) => _$SummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryToJson(this);

  @override
  List<Object> get props => [main, description, icon];
}
