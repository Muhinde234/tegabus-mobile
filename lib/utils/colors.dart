import 'dart:ui';
import 'package:flutter/material.dart';

class DColors {
  DColors._();

  // ── Brand primary (Deep Green #0B3B2E) ───────────────────────────────────
  static const Color primary = Color(0xFF0B3B2E);
  static const Color primary6 = Color(0xFF0B3B2E);
  static const Color primary5 = Color(0xCC0B3B2E);
  static const Color primary4 = Color(0x990B3B2E);
  static const Color primary3 = Color(0x660B3B2E);
  static const Color primary2 = Color(0x330B3B2E);
  static const Color primary1 = Color(0x1A0B3B2E);

  // ── Primary Light (for gradient endpoints) ────────────────────────────────
  static const Color primaryLight = Color(0xFF1A6B52);
  static const Color primaryMid = Color(0xFF145A44);

  // ── Secondary (Gold accent) ───────────────────────────────────────────────
  static const Color secondary = Color(0xFFF5A623);
  static const Color secondary6 = Color(0xFFF5A623);
  static const Color secondary5 = Color(0xCCF5A623);
  static const Color secondary2 = Color(0x33F5A623);
  static const Color secondary1 = Color(0x1AF5A623);

  // ── Success (Teal) ────────────────────────────────────────────────────────
  static const Color success6 = Color(0xFF0C7E6E);
  static const Color success5 = Color(0xCC0C7E6E);
  static const Color success4 = Color(0x990C7E6E);
  static const Color success3 = Color(0x660C7E6E);
  static const Color success2 = Color(0x330C7E6E);
  static const Color success1 = Color(0x1A0C7E6E);

  // ── Danger ────────────────────────────────────────────────────────────────
  static const Color danger6 = Color(0xFFE53935);
  static const Color danger5 = Color(0xCCE53935);
  static const Color danger2 = Color(0x33E53935);
  static const Color danger1 = Color(0x1AE53935);

  // ── Warning ───────────────────────────────────────────────────────────────
  static const Color warning6 = Color(0xFFF2A001);
  static const Color warning5 = Color(0xCCF2A001);
  static const Color warning4 = Color(0x99F2A001);
  static const Color warning3 = Color(0x66F2A001);
  static const Color warning2 = Color(0x33F2A001);
  static const Color warning1 = Color(0x1AF2A001);

  // ── Neutral (Dark Gray) ───────────────────────────────────────────────────
  static const Color neutral6 = Color(0xFF191919);
  static const Color neutral5 = Color(0xFF555555);
  static const Color neutral4 = Color(0xFF888888);
  static const Color neutral3 = Color(0xFFAAAAAA);
  static const Color neutral2 = Color(0xFFDDDDDD);
  static const Color neutral1 = Color(0xFFF5F5F5);

  // ── Background ────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF8FAF9);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F4F2);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0B3B2E), Color(0xFF145A44), Color(0xFF1A6B52)],
  );

  static const LinearGradient primaryGradientVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0B3B2E), Color(0xFF1A6B52)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF5A623), Color(0xFFE8941E)],
  );

  // ── Shadows ───────────────────────────────────────────────────────────────
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0xFF0B3B2E).withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: const Color(0xFF000000).withValues(alpha: 0.05),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: const Color(0xFF0B3B2E).withValues(alpha: 0.12),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ];
}

// ── Dark mode palette ──────────────────────────────────────────────────────
// Mirror of DColors with values calibrated for a dark canvas. Brand greens are
// brightened so they read as accents on a dark background instead of fading
// into it. Surfaces are flat dark greys (not pure black) to reduce eye strain.
class DColorsDark {
  DColorsDark._();

  // Lightened brand greens for legibility on dark surfaces.
  static const Color primary = Color(0xFF2E9E7C);
  static const Color primary6 = primary;
  static const Color primary5 = Color(0xCC2E9E7C);
  static const Color primary4 = Color(0x992E9E7C);
  static const Color primary3 = Color(0x662E9E7C);
  static const Color primary2 = Color(0x332E9E7C);
  static const Color primary1 = Color(0x1A2E9E7C);
  static const Color primaryLight = Color(0xFF4FBE9A);
  static const Color primaryMid = Color(0xFF3DAE8A);

  // Secondary stays gold — already pops on dark.
  static const Color secondary = Color(0xFFF5A623);
  static const Color secondary6 = secondary;
  static const Color secondary5 = Color(0xCCF5A623);
  static const Color secondary2 = Color(0x33F5A623);
  static const Color secondary1 = Color(0x1AF5A623);

  // Status colours, slightly desaturated for dark canvases.
  static const Color success6 = Color(0xFF2DBFA8);
  static const Color success5 = Color(0xCC2DBFA8);
  static const Color success4 = Color(0x992DBFA8);
  static const Color success3 = Color(0x662DBFA8);
  static const Color success2 = Color(0x332DBFA8);
  static const Color success1 = Color(0x1A2DBFA8);

  static const Color danger6 = Color(0xFFFF6B6B);
  static const Color danger5 = Color(0xCCFF6B6B);
  static const Color danger2 = Color(0x33FF6B6B);
  static const Color danger1 = Color(0x1AFF6B6B);

  static const Color warning6 = Color(0xFFFFB84D);
  static const Color warning5 = Color(0xCCFFB84D);
  static const Color warning4 = Color(0x99FFB84D);
  static const Color warning3 = Color(0x66FFB84D);
  static const Color warning2 = Color(0x33FFB84D);
  static const Color warning1 = Color(0x1AFFB84D);

  // Neutrals are inverted: 6 is now light (foreground), 1 is darkest (bg-ish).
  // Tuned to match the OneAuth/Authy-style dark theme — pure white primary
  // text, soft grey for secondary, with a clear separation between card and
  // body backgrounds.
  static const Color neutral6 = Color(0xFFFFFFFF); // primary text — pure white
  static const Color neutral5 = Color(0xFFE2E4EA); // secondary text
  static const Color neutral4 = Color(0xFFA0A4AE); // tertiary / labels
  static const Color neutral3 = Color(0xFF70747F);
  static const Color neutral2 = Color(0xFF2C2E36); // dividers / faint borders
  static const Color neutral1 = Color(0xFF1F2128);

  // Surface stack — ordered light to dark so cards float above background.
  // Background is near-black, card surface is a distinctly lighter charcoal
  // so cards float visually (matches OneAuth screenshot).
  static const Color background = Color(0xFF0A0B0F);
  static const Color surface = Color(0xFF1A1B22);
  static const Color surfaceVariant = Color(0xFF24262E);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F4D3D), Color(0xFF166650), Color(0xFF1F8467)],
  );

  static const LinearGradient primaryGradientVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F4D3D), Color(0xFF1F8467)],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF5A623), Color(0xFFE8941E)],
  );

  // Shadows are nearly invisible on dark — keep them subtle so cards don't
  // get a halo around them.
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
      ];
}

// ── Context-aware palette accessor ─────────────────────────────────────────
// Use this everywhere a colour might differ between light and dark. For
// brand-fixed surfaces (e.g. the green app header) keep using DColors directly
// because we want the brand green identical in both themes.
//
//   final c = context.colors;
//   color: c.background, // auto picks dark or light
class AppColors {
  /// Each getter picks the right side of the palette based on theme brightness.
  /// Constructed by the [AppColorsX.colors] extension on [BuildContext];
  /// you typically don't instantiate this directly.
  final bool isDark;
  const AppColors({required this.isDark});

  Color get background =>
      isDark ? DColorsDark.background : DColors.background;
  Color get surface => isDark ? DColorsDark.surface : DColors.surface;
  Color get surfaceVariant =>
      isDark ? DColorsDark.surfaceVariant : DColors.surfaceVariant;
  Color get primary => isDark ? DColorsDark.primary : DColors.primary;
  Color get primary1 => isDark ? DColorsDark.primary1 : DColors.primary1;
  Color get primary3 => isDark ? DColorsDark.primary3 : DColors.primary3;
  Color get neutral6 => isDark ? DColorsDark.neutral6 : DColors.neutral6;
  Color get neutral5 => isDark ? DColorsDark.neutral5 : DColors.neutral5;
  Color get neutral4 => isDark ? DColorsDark.neutral4 : DColors.neutral4;
  Color get neutral3 => isDark ? DColorsDark.neutral3 : DColors.neutral3;
  Color get neutral2 => isDark ? DColorsDark.neutral2 : DColors.neutral2;
  Color get neutral1 => isDark ? DColorsDark.neutral1 : DColors.neutral1;
  Color get danger1 => isDark ? DColorsDark.danger1 : DColors.danger1;
  Color get danger6 => isDark ? DColorsDark.danger6 : DColors.danger6;
  Color get success1 => isDark ? DColorsDark.success1 : DColors.success1;
  Color get success6 => isDark ? DColorsDark.success6 : DColors.success6;
  Color get warning1 => isDark ? DColorsDark.warning1 : DColors.warning1;
  Color get warning6 => isDark ? DColorsDark.warning6 : DColors.warning6;

  List<BoxShadow> get cardShadow =>
      isDark ? DColorsDark.cardShadow : DColors.cardShadow;
  List<BoxShadow> get softShadow =>
      isDark ? DColorsDark.softShadow : DColors.softShadow;
  List<BoxShadow> get elevatedShadow =>
      isDark ? DColorsDark.elevatedShadow : DColors.elevatedShadow;
}

extension AppColorsX on BuildContext {
  /// Returns the palette appropriate to the current theme brightness.
  /// Use over `DColors.*` when the colour should flip in dark mode.
  AppColors get colors =>
      AppColors(isDark: Theme.of(this).brightness == Brightness.dark);
}

