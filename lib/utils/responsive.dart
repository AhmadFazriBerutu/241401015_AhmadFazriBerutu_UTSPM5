import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class Responsive {
  Responsive._(this.size);

  factory Responsive.of(BuildContext context) =>
      Responsive._(MediaQuery.sizeOf(context));

  static const double _maxContentWidth = 560;
  static const double _baseWidth = 390;
  static const double _baseHeight = 780;

  final Size size;

  double get contentWidth => math.min(size.width, _maxContentWidth);

  bool get isWide => size.width >= 600;
  bool get isLandscape => size.width > size.height;

  double get scale {
    final byWidth = contentWidth / _baseWidth;
    final byHeight = size.height / _baseHeight;
    return math.min(byWidth, byHeight).clamp(0.7, 1.3).toDouble();
  }

  double s(double value) => value * scale;

  double hp(double fraction) => size.height * fraction;

  double wp(double fraction) => contentWidth * fraction;

  double fromShortest(
    double fraction, {
    double min = 0,
    double max = double.infinity,
  }) {
    return (size.shortestSide * fraction).clamp(min, max).toDouble();
  }
}