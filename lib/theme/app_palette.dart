import 'package:flutter/material.dart';

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.isDark,
    required this.bgEdge,
    required this.bgMid,
    required this.card,
    required this.surface,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.success,
    required this.successBorder,
    required this.danger,
    required this.dangerBorder,
    required this.shadow,
    required this.posterOpacity,
  });

  final bool isDark;
  final Color bgEdge;
  final Color bgMid;
  final Color card;
  final Color surface;
  final Color accent;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color success;
  final Color successBorder;
  final Color danger;
  final Color dangerBorder;
  final Color shadow;
  final double posterOpacity;

  static const AppPalette dark = AppPalette(
    isDark: true,
    bgEdge: Color(0xFF070B19),
    bgMid: Color(0xFF0F172A),
    card: Color(0xFF0F172A),
    surface: Color(0xFF1E293B),
    accent: Colors.amberAccent,
    textPrimary: Colors.white,
    textSecondary: Colors.white70,
    textMuted: Color(0xFF90A4AE),
    success: Colors.green,
    successBorder: Colors.greenAccent,
    danger: Colors.red,
    dangerBorder: Colors.redAccent,
    shadow: Color(0x66000000),
    posterOpacity: 0.4,
  );

  static const AppPalette light = AppPalette(
    isDark: false,
    bgEdge: Color(0xFFF8FAFC),
    bgMid: Color(0xFFE2E8F0),
    card: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    accent: Color(0xFFB45309),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF334155),
    textMuted: Color(0xFF64748B),
    success: Color(0xFF16A34A),
    successBorder: Color(0xFF15803D),
    danger: Color(0xFFDC2626),
    dangerBorder: Color(0xFFB91C1C),
    shadow: Color(0x33475569),
    posterOpacity: 0.25,
  );

  List<Shadow> glow(Color color, {double blur = 15}) =>
      isDark ? [Shadow(color: color, blurRadius: blur)] : const <Shadow>[];

  @override
  ThemeExtension<AppPalette> copyWith() => this;

  @override
  ThemeExtension<AppPalette> lerp(
    covariant ThemeExtension<AppPalette>? other,
    double t,
  ) {
    if (other is! AppPalette) return this;
    return t < 0.5 ? this : other;
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get colors =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.dark;
}