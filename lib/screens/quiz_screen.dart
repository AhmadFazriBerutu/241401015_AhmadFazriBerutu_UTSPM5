import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/quiz_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/app_background.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        if (quizProvider.isFinished) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 800),
                pageBuilder: (_, __, ___) => const ResultScreen(),
                transitionsBuilder: (_, animation, __, child) => FadeTransition(opacity: animation, child: child),
              ),
            );
          });
          return const Scaffold(
            backgroundColor: Color(0xFF070B19),
            body: Center(child: CircularProgressIndicator(color: Colors.amberAccent)),
          );
        }

        final currentQ = quizProvider.questions[quizProvider.currentIndex];
        final progress = (quizProvider.currentIndex + 1) / quizProvider.questions.length;
        final alphabet = ['A', 'B', 'C', 'D'];

        return Scaffold(
          body: AppBackground(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PERTANYAAN ${quizProvider.currentIndex + 1}/${quizProvider.questions.length}',
                        style: GoogleFonts.poppins(color: Colors.amberAccent, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                      ),
                      const Icon(Icons.timer_outlined, color: Colors.blueGrey, size: 24),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        key: ValueKey<int>(quizProvider.currentIndex),
                        padding: const EdgeInsets.all(32.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.amberAccent.withOpacity(0.3)),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 20, offset: const Offset(0, 10)),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: -20,
                              right: -20,
                              child: Text(
                                '${quizProvider.currentIndex + 1}',
                                style: GoogleFonts.cinzel(
                                  fontSize: 120,
                                  color: Colors.white.withOpacity(0.05),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Text(
                                currentQ.text,
                                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white, height: 1.5),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ...List.generate(
                    currentQ.options.length,
                    (index) {
                      Color? btnColor;
                      Color? borderColor;

                      if (quizProvider.isAnswerLocked) {
                        if (index == currentQ.answerIndex) {
                          btnColor = Colors.green.withOpacity(0.8);
                          borderColor = Colors.greenAccent;
                        } else if (index == quizProvider.selectedOptionIndex) {
                          btnColor = Colors.red.withOpacity(0.8);
                          borderColor = Colors.redAccent;
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: CustomButton(
                          prefixLabel: alphabet[index],
                          text: currentQ.options[index],
                          overrideColor: btnColor,
                          overrideBorderColor: borderColor,
                          onPressed: () => quizProvider.answerQuestion(index),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}