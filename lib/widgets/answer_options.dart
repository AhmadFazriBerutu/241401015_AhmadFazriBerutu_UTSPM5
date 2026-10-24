import 'package:flutter/material.dart';
import '../models/question.dart';
import '../theme/app_palette.dart';
import '../utils/responsive.dart';
import 'custom_button.dart';

class AnswerOptions extends StatelessWidget {
  const AnswerOptions({
    super.key,
    required this.question,
    required this.isLocked,
    required this.selectedIndex,
    required this.onSelected,
  });

  static const List<String> _letters = ['A', 'B', 'C', 'D'];

  final Question question;
  final bool isLocked;
  final int? selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final c = context.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(question.options.length, (index) {
        Color? fill;
        Color? border;

        if (isLocked) {
          if (index == question.answerIndex) {
            fill = c.success.withValues(alpha: 0.85);
            border = c.successBorder;
          } else if (index == selectedIndex) {
            fill = c.danger.withValues(alpha: 0.85);
            border = c.dangerBorder;
          }
        }

        return Padding(
          padding: EdgeInsets.only(bottom: r.s(16)),
          child: CustomButton(
            prefixLabel: _letters[index],
            text: question.options[index],
            overrideColor: fill,
            overrideBorderColor: border,
            onPressed: () => onSelected(index),
          ),
        );
      }),
    );
  }
}
