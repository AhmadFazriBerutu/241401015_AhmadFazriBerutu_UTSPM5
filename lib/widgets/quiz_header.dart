import 'package:flutter/material.dart';
import '../theme/app_fonts.dart';
import '../theme/app_palette.dart';
import '../utils/responsive.dart';
import 'quiz_timer.dart';

class QuizHeader extends StatelessWidget {
  const QuizHeader({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
    required this.timeLeft,
    required this.totalSeconds,
  });

  final int currentIndex;
  final int totalQuestions;
  final int timeLeft;
  final int totalSeconds;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final c = context.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'PERTANYAAN ${currentIndex + 1}/$totalQuestions',
                style: TextStyle(
                  fontFamily: AppFonts.body,
                  color: c.accent,
                  fontSize: r.s(14),
                  fontWeight: FontWeight.bold,
                  letterSpacing: r.s(1.5),
                ),
              ),
            ),
            SizedBox(width: r.s(12)),
            QuizTimer(timeLeft: timeLeft, totalSeconds: totalSeconds),
          ],
        ),
        SizedBox(height: r.s(16)),
        ClipRRect(
          borderRadius: BorderRadius.circular(r.s(10)),
          child: LinearProgressIndicator(
            value: (currentIndex + 1) / totalQuestions,
            backgroundColor: c.textPrimary.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(c.accent),
            minHeight: r.s(8),
          ),
        ),
      ],
    );
  }
}
