import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/data/enums_extensions/enums.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit._({required LanguageState state}) : super(state);

  factory LanguageCubit.initial({
    LanguageState? state,
    userProfile,
  }) {
    return LanguageCubit._(state: state ?? const LanguageInitial(currentLanguage: defaultLanguage));
  }
}
