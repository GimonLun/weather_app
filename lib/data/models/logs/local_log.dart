import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/data/enums_extensions/enums.dart';

part 'local_log.g.dart';

@HiveType(typeId: 100)
class LocalLog extends Equatable {
  @HiveField(0)
  final DateTime dateTime;

  @HiveField(1)
  final ActionType actionType;

  @HiveField(2)
  final Category category;

  @HiveField(3)
  final String pageName;

  @HiveField(4)
  final String? data;

  const LocalLog({
    required this.dateTime,
    required this.actionType,
    required this.category,
    required this.pageName,
    this.data,
  });

  @override
  List<Object> get props => [dateTime, actionType, category, pageName];
}
