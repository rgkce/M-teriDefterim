import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class AppTheme {
  // 🌞 Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: AppColors.lightSurface,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    textTheme: const TextTheme(
      headlineLarge: AppStyles.headline1,
      headlineMedium: AppStyles.headline2,
      bodyLarge: AppStyles.bodyText,
      bodyMedium: AppStyles.caption,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.primaryButton,
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: AppStyles.secondaryButton,
    ),

    inputDecorationTheme: AppStyles.inputDecorationTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightAccent,
      foregroundColor: Colors.white,
    ),
  );

  // 🌙 Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkSurface,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    textTheme: TextTheme(
      headlineLarge: AppStyles.headline1.copyWith(color: AppColors.darkText),
      headlineMedium: AppStyles.headline2.copyWith(color: AppColors.darkText),
      bodyLarge: AppStyles.bodyText.copyWith(color: AppColors.darkText),
      bodyMedium: AppStyles.caption.copyWith(
        color: AppColors.darkTextSecondary,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.primaryButton.copyWith(
        backgroundColor: const MaterialStatePropertyAll(AppColors.darkPrimary),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: AppStyles.secondaryButton.copyWith(
        foregroundColor: const MaterialStatePropertyAll(AppColors.darkPrimary),
        side: const MaterialStatePropertyAll(
          BorderSide(color: AppColors.darkPrimary, width: 1.5),
        ),
      ),
    ),

    inputDecorationTheme: AppStyles.inputDecorationTheme.copyWith(
      fillColor: AppColors.darkSurface,
      hintStyle: const TextStyle(color: AppColors.darkTextSecondary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkSecondary, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.darkPrimary, width: 2),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkAccent,
      foregroundColor: Colors.white,
    ),
  );
}
