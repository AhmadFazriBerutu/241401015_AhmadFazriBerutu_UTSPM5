import 'package:flutter/material.dart';
import '../theme/app_fonts.dart';
import '../theme/app_palette.dart';
import '../utils/responsive.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.index,
    required this.text,
    this.compact = false,
  });

  final int index;
  final String text;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final c = context.colors;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.center,
          fit: compact ? StackFit.loose : StackFit.expand,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey<int>(index),
        width: double.infinity,
        constraints: BoxConstraints(minHeight: r.s(180)),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: c.card.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(r.s(24)),
          border: Border.all(color: c.accent.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(
              color: c.shadow,
              blurRadius: r.s(20),
              offset: Offset(0, r.s(10)),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -r.s(20),
              right: -r.s(10),
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  fontFamily: AppFonts.display,
                  fontSize: r.s(120),
                  color: c.textPrimary.withValues(alpha: 0.05),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(r.s(28)),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: AppFonts.body,
                    fontSize: r.s(20),
                    fontWeight: FontWeight.w600,
                    color: c.textPrimary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
