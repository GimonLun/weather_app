part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  final ColorTheme colorTheme;
  final ThemeData themeData;

  const ThemeState({
    required this.colorTheme,
    required this.themeData,
  });

  factory ThemeState.initial() {
    return DefaultThemeState.initial();
  }

  @override
  List<Object> get props => [];
}

class DefaultThemeState extends ThemeState {
  const DefaultThemeState._({
    required ColorTheme colorTheme,
    required ThemeData themeData,
  }) : super(
          themeData: themeData,
          colorTheme: colorTheme,
        );

  factory DefaultThemeState.initial() {
    const colorTheme = ColorTheme(
      primaryColor: Color(0xFFF39C12),
      primaryVariantColor: Color(0xFFE67E22),
      secondaryColor: Color(0xFFF4F4F4),
      secondaryVariantColor: Color(0xFFFFEFEF),
      surfaceColor: Colors.white,
      backgroundColor: Colors.white,
      errorColor: Colors.red,
      onPrimaryColor: Colors.white,
      onSecondaryColor: Colors.black,
      onSurfaceColor: Colors.black,
      onBackgroundColor: Colors.black,
      onErrorColor: Colors.white,
      secondaryBackgroundColor: Color(0xFFFDF8EF),
      onSecondaryBackgroundColor: Colors.white,
    );

    final textTheme = _createTextThemeFromTemplate(colorTheme);

    final themeData = _createThemeDataFromTemplate(
      colorTheme: colorTheme,
      textTheme: textTheme,
    );

    return DefaultThemeState._(
      colorTheme: colorTheme,
      themeData: themeData,
    );
  }

  @override
  List<Object> get props => super.props..addAll([]);
}

///when define new color then add in here
///so we ensure every theme have same color attribute
class ColorTheme {
  final Color primaryColor, onPrimaryColor;
  final Color primaryVariantColor;
  final Color secondaryColor, onSecondaryColor;
  final Color secondaryVariantColor;
  final Color surfaceColor, onSurfaceColor;
  final Color backgroundColor, onBackgroundColor;
  final Color errorColor, onErrorColor;
  final Color secondaryBackgroundColor, onSecondaryBackgroundColor;

  const ColorTheme({
    required this.primaryColor,
    required this.primaryVariantColor,
    required this.secondaryColor,
    required this.secondaryVariantColor,
    required this.surfaceColor,
    required this.backgroundColor,
    required this.errorColor,
    required this.onPrimaryColor,
    required this.onSecondaryColor,
    required this.onSurfaceColor,
    required this.onBackgroundColor,
    required this.onErrorColor,
    required this.secondaryBackgroundColor,
    required this.onSecondaryBackgroundColor,
  });

  ColorScheme toColorScheme({
    Brightness brightness = Brightness.light,
  }) {
    return ColorScheme(
      primary: primaryColor,
      primaryVariant: primaryVariantColor,
      secondary: secondaryColor,
      secondaryVariant: secondaryVariantColor,
      surface: surfaceColor,
      background: backgroundColor,
      error: errorColor,
      onPrimary: onPrimaryColor,
      onSecondary: onSecondaryColor,
      onSurface: onSurfaceColor,
      onBackground: onBackgroundColor,
      onError: onErrorColor,
      brightness: brightness,
    );
  }
}

TextTheme _createTextThemeFromTemplate(
  ColorTheme colorTheme, {
  TextStyle? headline2,
  TextStyle? headline3,
  TextStyle? headline4,
  TextStyle? headline5,
  TextStyle? headline6,
  TextStyle? subtitle1,
  TextStyle? subtitle2,
  TextStyle? bodyText1,
  TextStyle? bodyText2,
  TextStyle? button,
  TextStyle? caption,
  TextStyle? overline,
}) {
  return TextTheme(
    headline2: headline2 ??
        TextStyle(
          fontSize: headline2FontSize,
          fontWeight: headline2FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    headline3: headline3 ??
        TextStyle(
          fontSize: headline3FontSize,
          fontWeight: headline3FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    headline4: headline4 ??
        TextStyle(
          fontSize: headline4FontSize,
          fontWeight: headline4FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    headline5: headline5 ??
        TextStyle(
          fontSize: headline5FontSize,
          fontWeight: headline5FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    headline6: headline6 ??
        TextStyle(
          fontSize: headline6FontSize,
          fontWeight: headline6FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    subtitle1: subtitle1 ??
        TextStyle(
          fontSize: subtitle1FontSize,
          fontWeight: subtitle1FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    subtitle2: subtitle2 ??
        TextStyle(
          fontSize: subtitle2FontSize,
          fontWeight: subtitle2FontWeight,
          color: colorTheme.onBackgroundColor.withOpacity(opacityMed),
        ),
    bodyText1: bodyText1 ??
        TextStyle(
          fontSize: bodyText1FontSize,
          fontWeight: bodyText1FontWeight,
          color: colorTheme.onBackgroundColor,
        ),
    bodyText2: bodyText2 ??
        TextStyle(
          fontSize: bodyText2FontSize,
          fontWeight: bodyText2FontWeight,
          color: colorTheme.onBackgroundColor.withOpacity(opacityMed),
        ),
    button: button ??
        TextStyle(
          fontSize: buttonFontSize,
          fontWeight: buttonFontWeight,
          color: colorTheme.onPrimaryColor,
        ),
    caption: caption ??
        TextStyle(
          fontSize: captionFontSize,
          fontWeight: captionFontWeight,
          color: colorTheme.onBackgroundColor.withOpacity(opacityMed),
        ),
    overline: overline ??
        TextStyle(
          fontSize: overlineFontSize,
          fontWeight: overlineFontWeight,
          color: colorTheme.onBackgroundColor.withOpacity(opacityMed),
        ),
  );
}

ThemeData _createThemeDataFromTemplate({
  required ColorTheme colorTheme,
  required TextTheme textTheme,
  AppBarTheme? appBarTheme,
  IconThemeData? iconTheme,
  TextButtonThemeData? textButtonTheme,
  DividerThemeData? dividerThemeData,
  Brightness brightness = Brightness.light,
}) {
  final colorScheme = colorTheme.toColorScheme(brightness: brightness);

  return ThemeData(
    primaryColor: colorTheme.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: colorTheme.backgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorTheme.primaryColor,
      foregroundColor: colorTheme.onPrimaryColor,
    ),
    appBarTheme: appBarTheme ??
        AppBarTheme(
          elevation: 0.0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: colorTheme.backgroundColor,
          ),
          titleTextStyle: textTheme.headline5!.copyWith(
            color: colorTheme.backgroundColor,
          ),
          backgroundColor: colorTheme.primaryColor,
        ),
    iconTheme: iconTheme ?? const IconThemeData(size: defaultIconSize),
    textButtonTheme: textButtonTheme ??
        TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: colorTheme.onBackgroundColor.withOpacity(opacityMed),
          ),
        ),
    dividerTheme: dividerThemeData ??
        DividerThemeData(
          space: defaultDividerSpace,
          thickness: defaultDividerThickness,
          color: colorTheme.onBackgroundColor.withOpacity(opacityLow),
        ),
    textTheme: textTheme,
    colorScheme: colorScheme,
  );
}
