import 'package:flutter/material.dart';
import '../theme/app_palette.dart';

class Rank {
  const Rank(this.name, this.color);

  final String name;
  final Color color;

  static const int godMinScore = 100;
  static const int titledDouluoMinScore = 90;
  static const int soulEmperorMinScore = 60;
  static const int soulElderMinScore = 30;

  factory Rank.fromScore(int score, AppPalette c) {
    final d = c.isDark;
    if (score >= godMinScore) return Rank('God', c.accent);
    if (score >= titledDouluoMinScore) {
      return Rank(
        'Titled Douluo',
        d ? Colors.purpleAccent : Colors.purple.shade700,
      );
    }
    if (score >= soulEmperorMinScore) {
      return Rank(
        'Soul Emperor',
        d ? Colors.cyanAccent : Colors.cyan.shade800,
      );
    }
    if (score >= soulElderMinScore) {
      return Rank(
        'Soul Elder',
        d ? Colors.lightBlueAccent : Colors.lightBlue.shade800,
      );
    }
    return Rank(
      'Soul Trainee',
      d ? Colors.blueGrey : Colors.blueGrey.shade600,
    );
  }
}