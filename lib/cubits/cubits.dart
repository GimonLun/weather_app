import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/city/city_list_cubit.dart';
import 'package:weather_app/cubits/commons/languages/language_cubit.dart';
import 'package:weather_app/cubits/commons/location/location_cubit.dart';
import 'package:weather_app/cubits/commons/log/log_cubit.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';

final globalBlocProviders = <BlocProvider>[
  BlocProvider<ThemeCubit>(
    create: (context) => ThemeCubit.initial(),
  ),
  BlocProvider<LanguageCubit>(
    create: (context) => LanguageCubit.initial(),
  ),
  BlocProvider<CityListCubit>(
    create: (context) => CityListCubit.initial(),
  ),
  BlocProvider<LocationCubit>(
    create: (context) => LocationCubit.initial(),
  ),
  BlocProvider<LogCubit>(
    create: (context) => LogCubit.initial(),
  ),
];
