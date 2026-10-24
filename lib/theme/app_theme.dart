import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_palette.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => _build(Brightness.dark, AppPalette.dark);
  static ThemeData get light => _build(Brightness.light, AppPalette.light);

  static ThemeData _build(Brightness brightness, AppPalette palette) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.accent,
        brightness: brightness,
      ),
      scaffoldBackgroundColor: palette.bgEdge,
    );

    return base.copyWith(
      extensions: <ThemeExtension<dynamic>>[palette],
      // Font dasar seluruh aplikasi: Poppins.
      // Judul memakai GoogleFonts.cinzel di tiap layar.
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).apply(
        bodyColor: palette.textPrimary,
        displayColor: palette.textPrimary,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: palette.accent,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: palette.dangerBorder,
        contentTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}