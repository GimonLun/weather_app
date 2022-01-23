import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:weather_app/constants/misc_constants.dart';
import 'package:weather_app/cubits/city/city_list_cubit.dart';
import 'package:weather_app/cubits/commons/languages/language_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/cubits/cubits.dart';
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/data/models/logs/local_log.dart';
import 'package:weather_app/repositories/open_weather_rest_client.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/hive_service.dart';
import 'package:weather_app/services/i18n_service.dart';
import 'package:weather_app/services/navigation_service.dart';

import 'data/enums_extensions/enums.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) => {
            //TODO log error to error login system (Sentry/Crashytics) or display comment error dialog for unhandle error
            Logger().e(details)
          };

      _registerDependencies();

      await _initHive();

      runApp(
        MultiBlocProvider(
          providers: globalBlocProviders,
          child: const App(),
        ),
      );
    },
    (error, stack) => {
      //TODO log error to error login system (Sentry/Crashytics) or display comment error dialog for unhandle error
      Logger().e(error, stack)
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

  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

Future<void> _initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CityAdapter());
  Hive.registerAdapter(ActionTypeAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(LanguageAdapter());
  Hive.registerAdapter(LocalLogAdapter());
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
    BlocProvider.of<LanguageCubit>(context).initAppLanguage();
    BlocProvider.of<ThemeCubit>(context).initAppTheme();
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
