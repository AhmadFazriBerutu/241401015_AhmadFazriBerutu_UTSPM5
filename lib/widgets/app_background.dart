import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  
  const AppBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF070B19), Color(0xFF0F172A), Color(0xFF070B19)],
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
              opacity: 0.4,
              child: Image.asset(
                'assets/images/poster.jpg',
                height: 450,
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