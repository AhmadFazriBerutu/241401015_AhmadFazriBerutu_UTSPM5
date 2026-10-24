import 'package:flutter/material.dart';
import '../theme/app_palette.dart';
import '../utils/responsive.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final c = context.colors;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [c.bgEdge, c.bgMid, c.bgEdge],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.transparent],
                stops: [0.3, 1.0],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Opacity(
              opacity: c.posterOpacity,
              child: Image.asset(
                'assets/images/poster.jpg',
                // Tinggi poster = 50% tinggi layar (dibatasi)
                height: r.hp(0.5).clamp(240.0, 520.0).toDouble(),
                width: double.infinity,
                fit: BoxFit.cover,
                alignment: const Alignment(0.0, -0.4),
              ),
            ),
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}