import 'package:flutter/material.dart';
import 'package:mobile/utils/colors.dart';

class DTheme {
  DTheme._();

  static ElevatedButtonThemeData get elevatedButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: DColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 0.3,
          ),
        ),
      );

  static OutlinedButtonThemeData get outlinedButtonThemeData =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: DColors.primary,
          side: const BorderSide(color: DColors.primary, width: 1.5),
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      );

  static InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        filled: true,
        fillColor: DColors.surfaceVariant,
        labelStyle:
            const TextStyle(fontSize: 14, color: DColors.neutral5),
        hintStyle:
            const TextStyle(fontSize: 14, color: DColors.neutral4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DColors.danger6, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: DColors.danger6, width: 2),
        ),
        errorMaxLines: 3,
      );

  static CardThemeData get cardThemeData => CardThemeData(
        elevation: 0,
        color: DColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.zero,
      );

  static AppBarTheme get appBarTheme => const AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: DColors.neutral6,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: DColors.neutral6),
      );

  static NavigationBarThemeData get navigationBarTheme =>
      NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: DColors.primary1,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: DColors.primary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            );
          }
          return const TextStyle(color: DColors.neutral4, fontSize: 11);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: DColors.primary, size: 22);
          }
          return const IconThemeData(color: DColors.neutral4, size: 22);
        }),
      );
}
