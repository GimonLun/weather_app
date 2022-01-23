import 'package:hive_flutter/hive_flutter.dart';

part 'category.g.dart';

@HiveType(typeId: 101)
enum Category {
  @HiveField(0)
  city,

  @HiveField(1)
  weather,

  @HiveField(2)
  setting,
}
