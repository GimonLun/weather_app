import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/cubits/city/city_list_cubit.dart';
import 'package:weather_app/cubits/commons/languages/language_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/cubits/cubits.dart';
import 'package:weather_app/screens/city/city_list_page.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

import 'data/enums_extensions/enums.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) => {
            //TODO handle flutter error
          };

      _registerDependencies();

      runApp(
        MultiBlocProvider(
          // Global cubit or bloc define here
          // Prevent unnecessary global cubit/bloc
          providers: globalBlocProviders,
          child: const App(),
        ),
      );
    },
    (error, stack) => {
      //TODO handle other error
    },
  );
}

void _registerDependencies() {
  EquatableConfig.stringify = true;

  getIt.registerLazySingleton<I18nService>(() => I18nService());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<CityListCubit>(context).initCityList();
  }

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
              home: const CityListPage(),
            );
          },
        );
      },
    );
  }
}
