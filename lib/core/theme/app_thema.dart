import 'package:flutter/material.dart';

class AppColors {
  // ── Core Brand ─────────────────────────────────────────────

  // Deep calm slate instead of bright purple
  static const primary = Color(0xFF374151);

  // Soft selected background
  static const primaryLight = Color(0xFFE5E7EB);

  // ── Feedback ──────────────────────────────────────────────

  // Muted green
  static const successBg = Color(0xFFE8F0E8);
  static const successText = Color(0xFF5E7B61);

  // Muted red
  static const failBg = Color(0xFFF6EAEA);
  static const failText = Color(0xFFB46A6A);

  // ── Streak ────────────────────────────────────────────────

  // Warm reflective beige
  static const streakBg = Color(0xFFF4E8D7);
  static const streakText = Color(0xFF8A5A2B);

  // ── Neutral ───────────────────────────────────────────────

  // Warm background
  static const background = Color(0xFFF5F3EE);

  // Clean white cards
  static const surface = Colors.white;

  // Softer border
  static const border = Color(0xFFE5E0D8);

  // Main text
  static const textPrimary = Color(0xFF1F1F1F);

  // Secondary text
  static const textSecondary = Color(0xFF6B6B6B);

  // Unselected chips
  static const chipUnselected = Color(0xFFF1EFEA);

  // Selected chip text
  static const chipSelected = Color(0xFF374151);

  // ── Progress Grid ─────────────────────────────────────────

  static const progressDone = Color(0xFF6B8E6E);
  static const progressFail = Color(0xFFB46A6A);
  static const progressEmpty = Color(0xFFD8D4CC);
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      surface: AppColors.surface,
    ),

    fontFamily: 'Lato',

    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        height: 1.2,
      ),

      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
        height: 1.45,
      ),

      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
  );
}
