import 'package:flutter/material.dart';

class GlobalThemData {
  GlobalThemData._();

  static ThemeData lightThemeData = _themeData(
    lightColorScheme,
    _lightFocusColor,
  );

  static ThemeData darkThemeData = _themeData(darkColorScheme, _darkFocusColor);

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static const Color brandedBlue = Colors.blueAccent;
  static const Color brandedOrange = Colors.orangeAccent;

  static ThemeData _themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: PredictiveBackPageTransitionsBuilder(),
        },
      ),
      // focusColor: focusColor,
      // scaffoldBackgroundColor: colorScheme.surface,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFF8f4c38),
    onPrimary: Color(0xFFffffff),
    secondary: Color(0xFF77574e),
    onSecondary: Color(0xFFffffff),
    tertiary: Color(0xFF2F4C6C),
    onTertiary: Color(0xFFffffff),
    error: Color(0xFFba1a1a),
    onError: Color(0xFFffffff),
    primaryContainer: Color(0xFFffdbd1),
    onPrimaryContainer: Color(0xFF3a0b01),
    secondaryContainer: Color(0xFFffdbd1),
    onSecondaryContainer: Color(0xFF2c150f),
    tertiaryContainer: Color(0xFFf5e1a7),
    onTertiaryContainer: Color(0xFF231b00),
    errorContainer: Color(0xFFffdad6),
    onErrorContainer: Color(0xFF410002),
    surfaceDim: Color(0xFFe8d6d2),
    surface: Color.fromARGB(255, 255, 255, 255),
    surfaceBright: Color(0xFFfff8f6),
    surfaceContainerLowest: Color(0xFFffffff),
    surfaceContainerLow: Color(0xFFFEFDFD),
    surfaceContainer: Color(0xFFfceae5),
    surfaceContainerHigh: Color(0xFFf7e4e0),
    surfaceContainerHighest: Color(0xFFf1dfda),
    onSurface: Color(0xFF231917),
    onSurfaceVariant: Color(0xFF53433f),
    outline: Color(0xFF85736e),
    outlineVariant: Color(0xFFd8c2bc),
    brightness: Brightness.light,
    inverseSurface: Color(0xFF392e2b),
    onInverseSurface: Color(0xFFffede8),
    inversePrimary: Color(0xFFffb5a0),
    scrim: Color(0xFF000000),
    shadow: Color(0xFF000000),
  );
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFffb5a0),
    onPrimary: Color(0xFF561f0f),
    secondary: Color(0xFFe7bdb2),
    onSecondary: Color(0xFF442a22),
    tertiary: Color(0xFFd8c58d),
    onTertiary: Color(0xFF3b2f05),
    error: Color(0xFFffb4ab),
    onError: Color(0xFF690005),
    primaryContainer: Color(0xFF723523),
    onPrimaryContainer: Color(0xFFffdbd1),
    secondaryContainer: Color(0xFF5d4037),
    onSecondaryContainer: Color(0xFFffdbd1),
    tertiaryContainer: Color(0xFF534619),
    onTertiaryContainer: Color(0xFFf5e1a7),
    errorContainer: Color(0xFF93000a),
    onErrorContainer: Color(0xFFffdad6),
    surfaceDim: Color(0xFF1a110f),
    surface: Color(0xFF1a110f),
    surfaceBright: Color(0xFF423734),
    surfaceContainerLowest: Color(0xFF140c0a),
    surfaceContainerLow: Color(0xFF231917),
    surfaceContainer: Color(0xFF271d1b),
    surfaceContainerHigh: Color(0xFF322825),
    surfaceContainerHighest: Color(0xFF3d322f),
    onSurface: Color(0xFFf1dfda),
    onSurfaceVariant: Color(0xFFd8c2bc),
    outline: Color(0xFFa08c87),
    outlineVariant: Color(0xFF53433f),
    brightness: Brightness.light,
    inverseSurface: Color(0xFFf1dfda),
    onInverseSurface: Color(0xFF392e2b),
    inversePrimary: Color(0xFF8f4c38),
    scrim: Color(0xFF000000),
    shadow: Color(0xFF000000),
  );
}
