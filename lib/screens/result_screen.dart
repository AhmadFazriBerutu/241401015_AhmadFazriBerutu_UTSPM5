import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  String _getSoulRank(int score) {
    if (score >= 100) return 'God';
    if (score >= 99) return 'Limit Douluo';
    if (score >= 95) return 'Super Douluo';
    if (score >= 91) return 'Titled Douluo';
    if (score >= 81) return 'Soul Douluo';
    if (score >= 71) return 'Soul Saint';
    if (score >= 61) return 'Soul Emperor';
    if (score >= 51) return 'Soul King';
    if (score >= 41) return 'Soul Ancestor';
    if (score >= 31) return 'Soul Elder';
    if (score >= 21) return 'Soul Grand Master';
    if (score >= 11) return 'Soul Master';
    return 'Soul Trainee';
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final rankName = _getSoulRank(quizProvider.score);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF09090E), Color(0xFF111D3B), Color(0xFF09090E)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.transparent],
                    stops: [0.5, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Container(
                  height: 280,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/poster.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment(0.0, -0.4),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.amberAccent, Colors.orange],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds),
                        child: Text(
                          'UJIAN SELESAI,\n${quizProvider.userName.toUpperCase()}!',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2.0,
                            shadows: [
                              Shadow(color: Colors.black87, blurRadius: 10, offset: Offset(2, 2)),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.amberAccent.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.amberAccent.withOpacity(0.4), width: 1.5),
                        ),
                        child: const Text(
                          'SKOR KEKUATAN SPIRITUAL',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.amberAccent,
                            letterSpacing: 3.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [Color(0xFF2A1B0A), Color(0xFF09090E)],
                            center: Alignment.center,
                            radius: 0.8,
                          ),
                          border: Border.all(color: Colors.amberAccent.withOpacity(0.6), width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amberAccent.withOpacity(0.25),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.8),
                              blurRadius: 15,
                              spreadRadius: -5,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${quizProvider.score}',
                            style: const TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              shadows: [
                                Shadow(color: Colors.orangeAccent, blurRadius: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Mencapai Tingkatan:',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rankName.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.amberAccent,
                          letterSpacing: 3.0,
                          shadows: [
                            Shadow(color: Colors.orangeAccent, blurRadius: 15),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'KEMBALI KE AKADEMI',
                        onPressed: () {
                          quizProvider.resetQuiz();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                            (route) => false,
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}