import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';

class CardInfoItem extends StatelessWidget {
  final String label;
  final String? info;
  final bool showArrow;
  final GestureTapCallback? onTap;

  const CardInfoItem({
    Key? key,
    required this.label,
    this.info,
    this.showArrow = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _textTheme = themeState.themeData.textTheme;
        final _colorTheme = themeState.colorTheme;
        final _subtitle1 = _textTheme.subtitle1!.copyWith(
          color: _colorTheme.onSurfaceColor,
        );

        return InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(spaceMid),
            child: Row(
              children: [
                Expanded(
                  child: Text(label, style: _subtitle1),
                ),
                Row(
                  children: [
                    if (info != null) Text(info!, style: _subtitle1),
                    if (showArrow)
                      Icon(
                        Icons.navigate_next,
                        color: _colorTheme.onSurfaceColor,
                      )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
