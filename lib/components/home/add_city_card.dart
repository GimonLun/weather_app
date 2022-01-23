import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/components/card/primary_card.dart';
import 'package:weather_app/constants/dimen_constants.dart';
import 'package:weather_app/cubits/commons/theme/theme_cubit.dart';
import 'package:weather_app/service_locator.dart';
import 'package:weather_app/services/i18n_service.dart';

class AddCityCard extends StatefulWidget {
  const AddCityCard({Key? key}) : super(key: key);

  @override
  _AddCityCardState createState() => _AddCityCardState();
}

class _AddCityCardState extends State<AddCityCard> {
  late I18nService _i18nService;

  @override
  void initState() {
    super.initState();

    _i18nService = getIt.get();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final _colorTheme = themeState.colorTheme;

        return Padding(
          padding: const EdgeInsets.only(top: spaceLarge),
          child: PrimaryCard(
            margin: EdgeInsets.zero,
            title: _i18nService.translate(context, 'add_city'),
            child: SizedBox(
              height: homePageCardContentHeight,
              child: ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: iconSizeLarge, height: iconSizeLarge),
                child: FittedBox(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: _colorTheme.onSurfaceColor,
                      onPrimary: _colorTheme.onErrorColor,
                    ),
                    child: Icon(
                      CupertinoIcons.add,
                      color: _colorTheme.surfaceColor.withOpacity(0.3),
                      size: defaultIconSize,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
