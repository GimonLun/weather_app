import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/cubits/city/city_list_cubit.dart';
import 'package:weather_app/cubits/commons/languages/language_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/cubits/cubits.dart';
import 'package:weather_app/repositories/open_weather_rest_client.dart';
import 'package:weather_app/screens/city/city_list_page.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';
import 'package:weather_app/services/navigation_service.dart';

import 'data/enums_extensions/enums.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) => {
            //TODO handle flutter error
            Logger().e(details)
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
      Logger().e(error, stack)
      //TODO handle other error
    },
  );
}

void _registerDependencies() {
  EquatableConfig.stringify = true;

  getIt.registerLazySingleton<I18nService>(() => I18nService());

  const _enableApiLog = !kReleaseMode;

  final _dio = Dio();
  _dio.interceptors.add(
    LogInterceptor(
      responseBody: _enableApiLog,
      requestBody: _enableApiLog,
    ),
  );

  getIt.registerLazySingleton<OpenWeatherRestClient>(() => OpenWeatherRestClient(_dio));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();

    _appRouter = AppRouter();

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
              onGenerateRoute: _appRouter.onGenerateRoute,
              home: const HomePage(),
            );
          },
        );
      },
    );
  }
}
