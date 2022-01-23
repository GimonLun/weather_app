import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/constants/storage_key_constants.dart';
import 'package:weather_app/data/enums_extensions/enums.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/hive_service.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final HiveService _hiveService;

  late Box _settingBox;

  LanguageCubit._({required LanguageState state})
      : _hiveService = getIt.get(),
        super(state);

  factory LanguageCubit.initial({
    LanguageState? state,
    userProfile,
  }) {
    return LanguageCubit._(state: state ?? const LanguageInitial(currentLanguage: defaultLanguage));
  }

  Future<void> initAppLanguage() async {
    _settingBox = await _hiveService.openBox(settingBoxKey);

    final _language = await _settingBox.get(settingLanguageKey) ?? defaultLanguage;

    emit(LanguageInitial(currentLanguage: _language));
  }

  Future<void> changeLanguage({required Language language}) async {
    await _settingBox.put(settingLanguageKey, language);
    emit(LanguageChangeSuccess(currentLanguage: language));
  }
}
