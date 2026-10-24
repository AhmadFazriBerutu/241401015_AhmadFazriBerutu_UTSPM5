import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_palette.dart';
import '../utils/page_routes.dart';
import '../utils/responsive.dart';
import '../widgets/answer_options.dart';
import '../widgets/app_background.dart';
import '../widgets/exit_dialog.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_header.dart';
import 'home_screen.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  Future<void> _confirmExit(BuildContext context, QuizProvider quiz) async {
    final navigator = Navigator.of(context);
    quiz.pauseTimer();

    final shouldExit = await showExitDialog(context);

    if (shouldExit) {
      quiz.resetQuiz();
      navigator.pushAndRemoveUntil(
        fadeRoute(const HomeScreen()),
        (route) => false,
      );
    } else {
      quiz.resumeTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, child) {
        final c = context.colors;

        if (quiz.isFinished) {
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
            body: Center(child: CircularProgressIndicator(color: c.accent)),
          );
        }

        final r = Responsive.of(context);
        final question = quiz.questions[quiz.currentIndex];

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop || quiz.isAnswerLocked) return;
            _confirmExit(context, quiz);
          },
          child: Scaffold(
            body: AppBackground(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxHeight < r.s(740);
                  final gap = compact ? r.s(20) : r.s(40);

                  final header = QuizHeader(
                    currentIndex: quiz.currentIndex,
                    totalQuestions: quiz.questions.length,
                    timeLeft: quiz.timeLeft,
                    totalSeconds: QuizProvider.secondsPerQuestion,
                  );
                  final card = QuestionCard(
                    index: quiz.currentIndex,
                    text: question.text,
                    compact: compact,
                  );
                  final options = AnswerOptions(
                    question: question,
                    isLocked: quiz.isAnswerLocked,
                    selectedIndex: quiz.selectedOptionIndex,
                    onSelected: quiz.answerQuestion,
                  );

                  final Widget content = compact
                      ? SingleChildScrollView(
                          padding: EdgeInsets.all(r.s(24)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              header,
                              SizedBox(height: gap),
                              card,
                              SizedBox(height: gap),
                              options,
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(r.s(24)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              header,
                              SizedBox(height: gap),
                              Expanded(child: card),
                              SizedBox(height: gap),
                              options,
                            ],
                          ),
                        );

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
}
