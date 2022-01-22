import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/cubits/commons/languages/language_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/cubits/cubits.dart';
import 'package:weather_app/screens/city_list.dart';

import 'data/enums_extensions/enums.dart';

void main() {
  runApp(
    MultiBlocProvider(
      // Global cubit or bloc define here
      // Prevent unnecessary global cubit/bloc
      providers: globalBlocProviders,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, languageState) {
            return MaterialApp(
              title: 'Weather App',
              theme: themeState.themeData,
              supportedLocales: Language.values.map(
                (language) => language.locale,
              ),
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                FlutterI18nDelegate(
                  translationLoader: FileTranslationLoader(
                    fallbackFile: defaultLanguage.locale.toString(),
                    basePath: 'assets/i18n',
                    useCountryCode: true,
                    forcedLocale: languageState.currentLanguage.locale,
                    decodeStrategies: [
                      JsonDecodeStrategy(),
                    ],
                  ),
                ),
              ],
              home: const CityList(),
            );
          },
        );
      },
    );
  }
}
