import 'package:hive_flutter/hive_flutter.dart';

part 'action_type.g.dart';

@HiveType(typeId: 102)
enum ActionType {
  @HiveField(0)
  create,

  @HiveField(1)
  read,

  @HiveField(2)
  update,

  @HiveField(3)
  delete,
}
