import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/constants/storage_key_constants.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/hive_service.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final HiveService _hiveService;

  late Box _settingBox;

  ThemeCubit._()
      : _hiveService = getIt.get(),
        super(ThemeState.initial());

  factory ThemeCubit.initial() {
    //the case of is register only happen when you mock the cubit in test case
    if (getIt.isRegistered<ThemeCubit>()) {
      return getIt.get<ThemeCubit>();
    }

    return ThemeCubit._();
  }

  Future<void> initAppTheme() async {
    _settingBox = await _hiveService.openBox(settingBoxKey);

    final _isDarkMode = await _settingBox.get(settingThemeKey) ?? false;

    emit(!_isDarkMode ? DefaultThemeState.initial() : DarkThemeState.initial());
  }

  Future<void> changeTheme() async {
    final _isDarkMode = state is DarkThemeState;

    await _settingBox.put(settingThemeKey, !_isDarkMode);

    emit(_isDarkMode ? DefaultThemeState.initial() : DarkThemeState.initial());
  }
}
