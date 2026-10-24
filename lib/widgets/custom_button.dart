import 'package:flutter/material.dart';
import '../theme/app_fonts.dart';
import '../theme/app_palette.dart';
import '../utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? prefixLabel;
  final Color? overrideColor;
  final Color? overrideBorderColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.prefixLabel,
    this.overrideColor,
    this.overrideBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final c = context.colors;
    final radius = BorderRadius.circular(r.s(16));

    final isFeedback =
        overrideColor != null && overrideColor != Colors.transparent;
    final textColor = isFeedback
        ? Colors.white
        : (overrideColor != null ? c.textPrimary : c.accent);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: r.contentWidth),
        child: InkWell(
          onTap: onPressed,
          borderRadius: radius,
          splashColor: c.accent.withValues(alpha: 0.3),
          highlightColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: r.s(18),
              horizontal: r.s(20),
            ),
            decoration: BoxDecoration(
              color: overrideColor ?? c.surface.withValues(alpha: 0.7),
              borderRadius: radius,
              border: Border.all(
                color: overrideBorderColor ?? c.accent.withValues(alpha: 0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: c.shadow,
                  blurRadius: r.s(8),
                  offset: Offset(0, r.s(4)),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: prefixLabel != null
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                if (prefixLabel != null) ...[
                  Container(
                    width: r.s(32),
                    height: r.s(32),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: c.accent.withValues(alpha: 0.8)),
                      color: c.card,
                    ),
                    child: Center(
                      child: Text(
                        prefixLabel!,
                        style: TextStyle(
                          fontFamily: AppFonts.body,
                          fontSize: r.s(14),
                          fontWeight: FontWeight.bold,
                          color: c.accent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: r.s(16)),
                ],
                if (icon != null) ...[
                  Icon(icon, color: c.accent, size: r.s(24)),
                  SizedBox(width: r.s(12)),
                ],
                Expanded(
                  flex: prefixLabel != null ? 1 : 0,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: AppFonts.body,
                      fontSize: r.s(15),
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      letterSpacing: 1.0,
                    ),
                    textAlign:
                        prefixLabel != null ? TextAlign.left : TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
