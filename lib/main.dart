import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/cubits/cubits.dart';
import 'package:weather_app/screens/city_list.dart';

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
        return MaterialApp(
          title: 'Weather App',
          theme: themeState.themeData,
          home: const CityList(),
        );
      },
    );
  }
}
