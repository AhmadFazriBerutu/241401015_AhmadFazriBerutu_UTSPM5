import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/app_background.dart';
import 'home_screen.dart';
import 'quiz_screen.dart'; // Import ini yang sebelumnya tertinggal

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  Map<String, dynamic> _getRankData(int score) {
    if (score >= 100) return {'name': 'God', 'color': Colors.amberAccent};
    if (score >= 91)
      return {'name': 'Titled Douluo', 'color': Colors.purpleAccent};
    if (score >= 61)
      return {'name': 'Soul Emperor', 'color': Colors.cyanAccent};
    if (score >= 31)
      return {'name': 'Soul Elder', 'color': Colors.lightBlueAccent};
    return {'name': 'Soul Trainee', 'color': Colors.blueGrey};
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final rankData = _getRankData(quizProvider.score);
    final totalQuestions = quizProvider.questions.length;
    final correctAnswers = quizProvider.score ~/ 10;

    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quizProvider.userName.toUpperCase(),
                style: GoogleFonts.cinzel(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 3.0,
                  shadows: [
                    const Shadow(
                        color: Colors.black87,
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'UJIAN AKADEMI SELESAI',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.blueGrey,
                  letterSpacing: 4.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(flex: 1),
              TweenAnimationBuilder(
                tween:
                    Tween<double>(begin: 0, end: quizProvider.score.toDouble()),
                duration: const Duration(seconds: 2),
                curve: Curves.easeOutQuart,
                builder: (context, double value, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: CircularProgressIndicator(
                          value: value / 100,
                          strokeWidth: 8,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(rankData['color']),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              rankData['color'].withOpacity(0.2),
                              const Color(0xFF070B19)
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: rankData['color'].withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${value.toInt()}',
                            style: GoogleFonts.poppins(
                              fontSize: 64,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              shadows: [
                                Shadow(color: rankData['color'], blurRadius: 15)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Mencapai Tingkatan:',
                style:
                    GoogleFonts.poppins(color: Colors.blueGrey, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                rankData['name'].toUpperCase(),
                style: GoogleFonts.cinzel(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: rankData['color'],
                  letterSpacing: 2.0,
                  shadows: [Shadow(color: rankData['color'], blurRadius: 15)],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Benar $correctAnswers dari $totalQuestions Soal',
                  style: GoogleFonts.poppins(
                      color: Colors.white70, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(flex: 2),
              CustomButton(
                text: 'ULANGI UJIAN',
                icon: Icons.refresh,
                onPressed: () {
                  quizProvider.resetQuiz();
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const QuizScreen(),
                      transitionsBuilder: (_, animation, __, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'KEMBALI KE BERANDA',
                icon: Icons.home_filled,
                overrideColor: Colors.transparent,
                onPressed: () {
                  quizProvider.resetQuiz();
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const HomeScreen(),
                      transitionsBuilder: (_, animation, __, child) =>
                          FadeTransition(opacity: animation, child: child),
                    ),
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
