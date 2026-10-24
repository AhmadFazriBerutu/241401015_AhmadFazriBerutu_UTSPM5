import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? prefixLabel;
  final Color? overrideColor;
  final Color? overrideBorderColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.prefixLabel,
    this.overrideColor,
    this.overrideBorderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.amberAccent.withOpacity(0.3),
          highlightColor: Colors.transparent,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              color: overrideColor ?? const Color(0xFF1E293B).withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: overrideBorderColor ?? Colors.amberAccent.withOpacity(0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: prefixLabel != null ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: [
                if (prefixLabel != null) ...[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.amberAccent.withOpacity(0.8)),
                      color: const Color(0xFF0F172A),
                    ),
                    child: Center(
                      child: Text(
                        prefixLabel!,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                if (icon != null) ...[
                  Icon(icon, color: Colors.amberAccent, size: 24),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  flex: prefixLabel != null ? 1 : 0,
                  child: Text(
                    text,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: overrideColor != null ? Colors.white : Colors.amberAccent,
                      letterSpacing: 1.0,
                    ),
                    textAlign: prefixLabel != null ? TextAlign.left : TextAlign.center,
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