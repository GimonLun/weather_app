import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

/// Wrapper around i18n translate libraries.
/// This is necessary as there is a bug in running flutter test --coverage that crashes in CI.
/// The solution is to turn off assets using --no-test-assets, but this causes the flutter_i18n library to crash.
/// Hence a workaround is to wrap the library in a class like this, and mock it in unit tests.
/// This also enables a benefit that allows to change the i18n library easily if needed.
class I18nService {
  String translate(
    BuildContext context,
    String key, {
    Map<String, String>? translationParams,
  }) =>
      FlutterI18n.translate(context, key, translationParams: translationParams);
}
