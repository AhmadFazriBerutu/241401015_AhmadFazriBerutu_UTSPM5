import 'package:flutter/material.dart';
import '../theme/app_fonts.dart';
import '../theme/app_palette.dart';

Future<bool> showExitDialog(BuildContext context) async {
  final c = context.colors;

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      backgroundColor: c.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: c.accent.withValues(alpha: 0.5)),
      ),
      title: Text(
        'Keluar dari ujian?',
        style: TextStyle(
          fontFamily: AppFonts.display,
          color: c.accent,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Progres ujian kamu akan hilang dan skor di-reset.',
        style: TextStyle(
          fontFamily: AppFonts.body,
          color: c.textSecondary,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: Text(
            'LANJUTKAN',
            style: TextStyle(
              fontFamily: AppFonts.body,
              color: c.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(
            'KELUAR',
            style: TextStyle(
              fontFamily: AppFonts.body,
              color: c.dangerBorder,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );

  return result ?? false;
}
