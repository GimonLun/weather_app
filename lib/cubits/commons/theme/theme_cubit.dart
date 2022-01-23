import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/service_locator.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit._() : super(ThemeState.initial());

  factory ThemeCubit.initial() {
    //the case of is register only happen when you mock the cubit in test case
    if (getIt.isRegistered<ThemeCubit>()) {
      return getIt.get<ThemeCubit>();
    }

    return ThemeCubit._();
  }

  void changeTheme() {
    emit(state is DarkThemeState ? DefaultThemeState.initial() : DarkThemeState.initial());
  }
}
