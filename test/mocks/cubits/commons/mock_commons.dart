import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/cubits/commons/languages/language_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/data/enums_extensions/language.dart';

import 'mock_commons.mocks.dart';

@GenerateMocks([
  LanguageCubit,
  ThemeCubit,
])
void main() {}

MockLanguageCubit mockLanguageCubit({
  LanguageState? state,
  Stream<LanguageState>? stream,
}) {
  final _cubit = MockLanguageCubit();

  final _state = state ?? const LanguageUpdateSuccess(currentLanguage: Language.en);
  final _stream = stream?.asBroadcastStream() ?? Stream.fromFuture(Future.value(_state)).asBroadcastStream();

  when(_cubit.stream).thenAnswer((_) => _stream);
  when(_cubit.state).thenReturn(_state);

  return _cubit;
}

MockThemeCubit mockThemeCubit({
  ThemeState? state,
  Stream<ThemeState>? stream,
}) {
  final _cubit = MockThemeCubit();

  final _state = state ?? DefaultThemeState.initial();
  final _stream = stream?.asBroadcastStream() ?? Stream.fromFuture(Future.value(_state)).asBroadcastStream();

  when(_cubit.stream).thenAnswer((_) => _stream);
  when(_cubit.state).thenReturn(_state);

  return _cubit;
}
