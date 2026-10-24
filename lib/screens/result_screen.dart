import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/rank.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_fonts.dart';
import '../theme/app_palette.dart';
import '../utils/page_routes.dart';
import '../utils/responsive.dart';
import '../widgets/app_background.dart';
import '../widgets/custom_button.dart';
import '../widgets/score_ring.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.read<QuizProvider>();
    final r = Responsive.of(context);
    final c = context.colors;
    final rank = Rank.fromScore(quiz.score, c);
    final totalQuestions = quiz.questions.length;
    final correctAnswers = quiz.score ~/ QuizProvider.pointsPerQuestion;
    final ringSize = r.fromShortest(0.46, min: 120, max: 230);

    return Scaffold(
      body: AppBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: r.s(24)),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    maxWidth: r.contentWidth,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: r.s(16)),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            quiz.userName.toUpperCase(),
                            style: TextStyle(
                              fontFamily: AppFonts.display,
                              fontSize: r.s(32),
                              fontWeight: FontWeight.w900,
                              color: c.textPrimary,
                              letterSpacing: r.s(3),
                              shadows: c.isDark
                                  ? [
                                      Shadow(
                                        color: Colors.black87,
                                        blurRadius: r.s(10),
                                        offset: Offset(r.s(2), r.s(2)),
                                      ),
                                    ]
                                  : null,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: r.s(8)),
                        Text(
                          'UJIAN AKADEMI SELESAI',
                          style: TextStyle(
                            fontFamily: AppFonts.body,
                            fontSize: r.s(12),
                            color: c.textMuted,
                            letterSpacing: r.s(4),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(flex: 1),
                        ScoreRing(
                          score: quiz.score,
                          maxScore: quiz.maxScore,
                          color: rank.color,
                          size: ringSize,
                        ),
                        SizedBox(height: r.s(24)),
                        Text(
                          'Mencapai Tingkatan:',
                          style: TextStyle(
                            fontFamily: AppFonts.body,
                            color: c.textMuted,
                            fontSize: r.s(14),
                          ),
                        ),
                        SizedBox(height: r.s(4)),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            rank.name.toUpperCase(),
                            style: TextStyle(
                              fontFamily: AppFonts.display,
                              fontSize: r.s(28),
                              fontWeight: FontWeight.w900,
                              color: rank.color,
                              letterSpacing: r.s(2),
                              shadows: c.glow(rank.color),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: r.s(16)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: r.s(16),
                            vertical: r.s(8),
                          ),
                          decoration: BoxDecoration(
                            color: c.textPrimary.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(r.s(20)),
                          ),
                          child: Text(
                            'Benar $correctAnswers dari $totalQuestions Soal',
                            style: TextStyle(
                              fontFamily: AppFonts.body,
                              fontSize: r.s(14),
                              color: c.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Spacer(flex: 2),
                        SizedBox(height: r.s(24)),
                        CustomButton(
                          text: 'ULANGI UJIAN',
                          icon: Icons.refresh,
                          onPressed: () {
                            quiz.startQuiz();
                            Navigator.pushReplacement(
                              context,
                              fadeRoute(const QuizScreen()),
                            );
                          },
                        ),
                        SizedBox(height: r.s(16)),
                        CustomButton(
                          text: 'KEMBALI KE BERANDA',
                          icon: Icons.home_filled,
                          overrideColor: Colors.transparent,
                          onPressed: () {
                            quiz.resetQuiz();
                            Navigator.pushAndRemoveUntil(
                              context,
                              fadeRoute(const HomeScreen()),
                              (route) => false,
                            );
                          },
                        ),
                        SizedBox(height: r.s(32)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
