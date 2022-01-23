import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'language.g.dart';

@HiveType(typeId: 103)
enum Language {
  @HiveField(0)
  en,

  @HiveField(1)
  cn
}

extension LanguageExtension on Language {
  Locale get locale {
    switch (this) {
      case Language.cn:
        return const Locale('zh', 'CN');
      default:
        return const Locale('en', 'GB');
    }
  }

  String get shortName {
    switch (this) {
      case Language.cn:
        return 'zh';
      default:
        return 'en';
    }
  }
}
