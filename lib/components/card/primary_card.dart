import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';

class PrimaryCard extends StatelessWidget {
  final String title;
  final Widget child;
  final EdgeInsets? margin;

  const PrimaryCard({
    Key? key,
    required this.title,
    required this.child,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _textTheme = themeState.themeData.textTheme;
        final _colorTheme = themeState.colorTheme;

        return Card(
          margin:
              margin ?? const EdgeInsets.fromLTRB(screenBoundingSpace, screenBoundingSpace, screenBoundingSpace, 0.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: spaceLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: spaceXMid),
                      child: Text(
                        title,
                        style: _textTheme.subtitle1!.copyWith(
                          color: _colorTheme.onSurfaceColor,
                        ),
                      ),
                    ),
                    Divider(color: _colorTheme.onSurfaceColor),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: spaceXMid),
                  child: child,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
