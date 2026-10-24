import 'package:flutter/material.dart';
import '../theme/app_fonts.dart';
import '../theme/app_palette.dart';
import '../utils/responsive.dart';

class QuizTimer extends StatelessWidget {
  const QuizTimer({
    super.key,
    required this.timeLeft,
    required this.totalSeconds,
    this.urgentThreshold = 5,
  });

  final int timeLeft;
  final int totalSeconds;
  final int urgentThreshold;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final c = context.colors;
    final color = timeLeft <= urgentThreshold ? c.dangerBorder : c.accent;

    return SizedBox(
      width: r.s(46),
      height: r.s(46),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CircularProgressIndicator(
              value: timeLeft / totalSeconds,
              strokeWidth: r.s(4),
              backgroundColor: c.textPrimary.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          Text(
            '$timeLeft',
            style: TextStyle(
              fontFamily: AppFonts.body,
              color: color,
              fontSize: r.s(14),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
