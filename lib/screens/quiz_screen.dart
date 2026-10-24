import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/question.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_palette.dart';
import '../utils/page_routes.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/app_background.dart';
import 'home_screen.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  static const List<String> _letters = ['A', 'B', 'C', 'D'];

  Future<void> _confirmExit(
    BuildContext context,
    QuizProvider quizProvider,
  ) async {
    final navigator = Navigator.of(context);
    final c = context.colors;
    quizProvider.pauseTimer();

    final shouldExit = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: c.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: c.accent.withOpacity(0.5)),
        ),
        title: Text(
          'Keluar dari ujian?',
          style: GoogleFonts.cinzel(
            color: c.accent,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Progres ujian kamu akan hilang dan skor di-reset.',
          style: GoogleFonts.poppins(color: c.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'LANJUTKAN',
              style: GoogleFonts.poppins(
                color: c.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'KELUAR',
              style: GoogleFonts.poppins(
                color: c.dangerBorder,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );

    if (shouldExit == true) {
      quizProvider.resetQuiz();
      navigator.pushAndRemoveUntil(
        fadeRoute(const HomeScreen()),
        (route) => false,
      );
    } else {
      quizProvider.resumeTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        final c = context.colors;

        if (quizProvider.isFinished) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              fadeRoute(
                const ResultScreen(),
                duration: const Duration(milliseconds: 800),
              ),
            );
          });
          return Scaffold(
            backgroundColor: c.bgEdge,
            body: Center(
              child: CircularProgressIndicator(color: c.accent),
            ),
          );
        }

        final r = Responsive.of(context);
        final currentQ = quizProvider.questions[quizProvider.currentIndex];
        final progress =
            (quizProvider.currentIndex + 1) / quizProvider.questions.length;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            // Abaikan saat jeda umpan balik jawaban.
            if (quizProvider.isAnswerLocked) return;
            _confirmExit(context, quizProvider);
          },
          child: Scaffold(
            body: AppBackground(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Konten butuh kira-kira 740 satuan skala; jika ruang
                  // kurang, halaman dibuat bisa di-scroll.
                  final compact = constraints.maxHeight < r.s(740);
                  final gap = compact ? r.s(20) : r.s(40);

                  final header = _buildHeader(quizProvider, progress, r, c);
                  final card = _buildQuestionCard(
                    quizProvider,
                    currentQ,
                    r,
                    c,
                    compact: compact,
                  );
                  final options = _buildOptions(quizProvider, currentQ, r, c);

                  final Widget content = compact
                      ? SingleChildScrollView(
                          padding: EdgeInsets.all(r.s(24)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...header,
                              SizedBox(height: gap),
                              card,
                              SizedBox(height: gap),
                              ...options,
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(r.s(24)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...header,
                              SizedBox(height: gap),
                              Expanded(child: card),
                              SizedBox(height: gap),
                              ...options,
                            ],
                          ),
                        );

                  // Tablet / web: konten dibatasi dan diletakkan di tengah.
                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: r.contentWidth),
                      child: content,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimer(QuizProvider quizProvider, Responsive r, AppPalette c) {
    final fraction = quizProvider.timeLeft / QuizProvider.secondsPerQuestion;
    final urgent = quizProvider.timeLeft <= 5;
    final color = urgent ? c.dangerBorder : c.accent;

    return SizedBox(
      width: r.s(46),
      height: r.s(46),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CircularProgressIndicator(
              value: fraction,
              strokeWidth: 4,
              backgroundColor: c.textPrimary.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          Text(
            '${quizProvider.timeLeft}',
            style: GoogleFonts.poppins(
              color: color,
              fontSize: r.s(14),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHeader(
    QuizProvider quizProvider,
    double progress,
    Responsive r,
    AppPalette c,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              'PERTANYAAN ${quizProvider.currentIndex + 1}/${quizProvider.questions.length}',
              style: GoogleFonts.poppins(
                color: c.accent,
                fontSize: r.s(14),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
          SizedBox(width: r.s(12)),
          _buildTimer(quizProvider, r, c),
        ],
      ),
      SizedBox(height: r.s(16)),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: c.textPrimary.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation<Color>(c.accent),
          minHeight: r.s(8),
        ),
      ),
    ];
  }

  Widget _buildQuestionCard(
    QuizProvider quizProvider,
    Question currentQ,
    Responsive r,
    AppPalette c, {
    required bool compact,
  }) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      // StackFit.expand: kartu mengisi seluruh ruang Expanded (layar normal).
      // StackFit.loose: kartu mengikuti tinggi minimum (mode scroll).
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
        key: ValueKey<int>(quizProvider.currentIndex),
        width: double.infinity,
        constraints: BoxConstraints(minHeight: r.s(180)),
        clipBehavior: Clip.antiAlias, // watermark terpotong di tepi kartu
        decoration: BoxDecoration(
          color: c.card.withOpacity(0.85),
          borderRadius: BorderRadius.circular(r.s(24)),
          border: Border.all(color: c.accent.withOpacity(0.35)),
          boxShadow: [
            BoxShadow(
              color: c.shadow,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -r.s(20),
              right: -r.s(10),
              child: Text(
                '${quizProvider.currentIndex + 1}',
                style: GoogleFonts.cinzel(
                  fontSize: r.s(120),
                  color: c.textPrimary.withOpacity(0.05),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(r.s(28)),
              child: Center(
                child: Text(
                  currentQ.text,
                  style: GoogleFonts.poppins(
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

  List<Widget> _buildOptions(
    QuizProvider quizProvider,
    Question currentQ,
    Responsive r,
    AppPalette c,
  ) {
    return List.generate(currentQ.options.length, (index) {
      Color? btnColor;
      Color? borderColor;

      if (quizProvider.isAnswerLocked) {
        if (index == currentQ.answerIndex) {
          btnColor = c.success.withOpacity(0.85);
          borderColor = c.successBorder;
        } else if (index == quizProvider.selectedOptionIndex) {
          btnColor = c.danger.withOpacity(0.85);
          borderColor = c.dangerBorder;
        }
      }

      return Padding(
        padding: EdgeInsets.only(bottom: r.s(16)),
        child: CustomButton(
          prefixLabel: _letters[index],
          text: currentQ.options[index],
          overrideColor: btnColor,
          overrideBorderColor: borderColor,
          onPressed: () => quizProvider.answerQuestion(index),
        ),
      );
    });
  }
}