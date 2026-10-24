import 'package:flutter/material.dart';
import '../theme/app_fonts.dart';
import '../theme/app_palette.dart';

class ScoreRing extends StatelessWidget {
  const ScoreRing({
    super.key,
    required this.score,
    required this.maxScore,
    required this.color,
    required this.size,
  });

  final int score;
  final int maxScore;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final inner = size * 0.83;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: score.toDouble()),
      duration: const Duration(seconds: 2),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: value / maxScore,
                strokeWidth: size * 0.045,
                backgroundColor: c.textPrimary.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Container(
              width: inner,
              height: inner,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [color.withValues(alpha: 0.2), c.bgEdge],
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: size * 0.13,
                    spreadRadius: size * 0.02,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  '${value.toInt()}',
                  style: TextStyle(
                    fontFamily: AppFonts.body,
                    fontSize: size * 0.36,
                    fontWeight: FontWeight.w900,
                    color: c.textPrimary,
                    shadows: c.glow(color),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
