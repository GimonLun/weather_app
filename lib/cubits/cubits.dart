import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/commons/languages/language_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';

final globalBlocProviders = <BlocProvider>[
  BlocProvider<ThemeCubit>(
    create: (context) => ThemeCubit.initial(),
  ),
  BlocProvider<LanguageCubit>(
    create: (context) => LanguageCubit.initial(),
  ),
];
