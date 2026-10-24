import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_palette.dart';
import '../utils/page_routes.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/app_background.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';

class _Rank {
  final String name;
  final Color color;
  const _Rank(this.name, this.color);
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  // Warna rank menyesuaikan tema agar tetap terbaca di latar terang.
  _Rank _getRank(int score, AppPalette c) {
    final d = c.isDark;
    if (score >= 100) return _Rank('God', c.accent);
    if (score >= 91) {
      return _Rank(
        'Titled Douluo',
        d ? Colors.purpleAccent : Colors.purple.shade700,
      );
    }
    if (score >= 61) {
      return _Rank(
        'Soul Emperor',
        d ? Colors.cyanAccent : Colors.cyan.shade800,
      );
    }
    if (score >= 31) {
      return _Rank(
        'Soul Elder',
        d ? Colors.lightBlueAccent : Colors.lightBlue.shade800,
      );
    }
    return _Rank(
      'Soul Trainee',
      d ? Colors.blueGrey : Colors.blueGrey.shade600,
    );
  }

  @override
  Widget build(BuildContext context) {
    // read (bukan watch): tampilan hasil tidak ikut berubah ke 0
    // saat tombol Ulangi/Kembali me-reset provider.
    final quizProvider = context.read<QuizProvider>();
    final r = Responsive.of(context);
    final c = context.colors;
    final rank = _getRank(quizProvider.score, c);
    final totalQuestions = quizProvider.questions.length;
    final correctAnswers = quizProvider.score ~/ 10;

    // Cincin skor = 46% sisi terpendek layar (dibatasi 120 - 230)
    final ringOuter = r.fromShortest(0.46, min: 120, max: 230);
    final ringInner = ringOuter * 0.83;

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
                            quizProvider.userName.toUpperCase(),
                            style: GoogleFonts.cinzel(
                              fontSize: r.s(32),
                              fontWeight: FontWeight.w900,
                              color: c.textPrimary,
                              letterSpacing: r.s(3),
                              shadows: c.isDark
                                  ? const [
                                      Shadow(
                                        color: Colors.black87,
                                        blurRadius: 10,
                                        offset: Offset(2, 2),
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
                          style: GoogleFonts.poppins(
                            fontSize: r.s(12),
                            color: c.textMuted,
                            letterSpacing: 4.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(flex: 1),
                        TweenAnimationBuilder(
                          tween: Tween<double>(
                            begin: 0,
                            end: quizProvider.score.toDouble(),
                          ),
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeOutQuart,
                          builder: (context, double value, child) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: ringOuter,
                                  height: ringOuter,
                                  child: CircularProgressIndicator(
                                    value: value / 100,
                                    strokeWidth: ringOuter * 0.045,
                                    backgroundColor:
                                        c.textPrimary.withOpacity(0.1),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      rank.color,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: ringInner,
                                  height: ringInner,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        rank.color.withOpacity(0.2),
                                        c.bgEdge,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: rank.color.withOpacity(0.3),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${value.toInt()}',
                                      style: GoogleFonts.poppins(
                                        fontSize: ringOuter * 0.36,
                                        fontWeight: FontWeight.w900,
                                        color: c.textPrimary,
                                        shadows: c.glow(rank.color),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: r.s(24)),
                        Text(
                          'Mencapai Tingkatan:',
                          style: GoogleFonts.poppins(
                            color: c.textMuted,
                            fontSize: r.s(14),
                          ),
                        ),
                        SizedBox(height: r.s(4)),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            rank.name.toUpperCase(),
                            style: GoogleFonts.cinzel(
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
                            color: c.textPrimary.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(r.s(20)),
                          ),
                          child: Text(
                            'Benar $correctAnswers dari $totalQuestions Soal',
                            style: GoogleFonts.poppins(
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
                            quizProvider.startQuiz();
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
                            quizProvider.resetQuiz();
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