import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const primary = Color(0xFF4F3DD0); // deep violet (CTA button)
  static const primaryLight = Color(0xFFEDEBFB);

  // Feedback
  static const successBg = Color(0xFFE8F5E9);
  static const successText = Color(0xFF2E7D32);
  static const failBg = Color(0xFFFFEBEE);
  static const failText = Color(0xFFC62828);

  // Streak
  static const streakBg = Color(0xFFFFF3E0);
  static const streakText = Color(0xFFE65100);

  // Neutral
  static const background = Color(0xFFF5F4F0);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE0DED8);
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF6B6B6B);
  static const chipUnselected = Color(0xFFEEECE8);
  static const chipSelected = Color(0xFF1A1A1A);

  // Progress grid
  static const progressDone = Color(0xFF388E3C);
  static const progressFail = Color(0xFFE53935);
  static const progressEmpty = Color(0xFFD9D7D2);
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      surface: AppColors.background,
    ),
    fontFamily: 'Lato',
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        height: 1.25,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
  );
}
