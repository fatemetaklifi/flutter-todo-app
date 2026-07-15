import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: "beiruti",

    colorScheme: ColorScheme.light(
      primary: LightColors.primary,
      secondary: LightColors.secondary,
    ),

    scaffoldBackgroundColor: LightColors.background,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: LightColors.primary,
      foregroundColor: LightColors.background,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: LightColors.accent,
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: LightColors.primary,
      selectionHandleColor: LightColors.primary,
      selectionColor: LightColors.secondary.withValues(alpha: 0.3),
    ),

    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(Colors.white),
      disabledColor: Colors.white,
      selectedColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: "beiruti",

    colorScheme: ColorScheme.dark(
      primary: DarkColors.primary,
      secondary: DarkColors.secondary,
    ),

    scaffoldBackgroundColor: DarkColors.background,

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: DarkColors.primary,
      foregroundColor: DarkColors.background,
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: DarkColors.accent,
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: DarkColors.primary,
      selectionHandleColor: DarkColors.primary,
      selectionColor: DarkColors.secondary.withValues(alpha: 0.3),
    ),
  );
}
