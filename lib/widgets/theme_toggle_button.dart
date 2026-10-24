import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_palette.dart';
import '../utils/responsive.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final r = Responsive.of(context);

    return Tooltip(
      message: c.isDark ? 'Mode terang' : 'Mode gelap',
      child: Material(
        color: c.surface.withValues(alpha: 0.7),
        shape: CircleBorder(
          side: BorderSide(color: c.accent.withValues(alpha: 0.5)),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => context
              .read<ThemeProvider>()
              .setMode(c.isDark ? ThemeMode.light : ThemeMode.dark),
          child: SizedBox(
            width: r.s(44),
            height: r.s(44),
            child: Icon(
              c.isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              color: c.accent,
              size: r.s(22),
            ),
          ),
        ),
      ),
    );
  }
}
