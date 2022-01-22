import 'package:flutter/material.dart';

enum Language { en, cn }

extension LanguageExtension on Language {
  Locale get locale {
    switch (this) {
      case Language.cn:
        return const Locale('zh', 'CN');
      default:
        return const Locale('en', 'GB');
    }
  }

  String get displayName {
    switch (this) {
      case Language.cn:
        return 'chinese';
      default:
        return 'english';
    }
  }
}
