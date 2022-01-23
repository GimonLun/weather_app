import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  Future<Box<E>> openBox<E>(String name) {
    return Hive.openBox(name);
  }
}
