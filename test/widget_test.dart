import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:aplikasi_kuis_pilihan_ganda/main.dart';
import 'package:aplikasi_kuis_pilihan_ganda/models/rank.dart';
import 'package:aplikasi_kuis_pilihan_ganda/providers/quiz_provider.dart';
import 'package:aplikasi_kuis_pilihan_ganda/providers/theme_provider.dart';
import 'package:aplikasi_kuis_pilihan_ganda/theme/app_palette.dart';

Widget _buildApp() => MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    );

void main() {
  testWidgets('Home menampilkan judul dan tombol mulai', (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pump();

    expect(find.text('SOUL LAND'), findsOneWidget);
    expect(find.text('MULAI UJIAN'), findsOneWidget);
  });

  testWidgets('Tombol tema berganti antara mode gelap dan terang',
      (tester) async {
    await tester.pumpWidget(_buildApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.light_mode_outlined));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
  });

  test('QuizProvider menambah skor 10 untuk jawaban benar', () async {
    final quiz = QuizProvider();
    final correct = quiz.questions[0].answerIndex;

    await quiz.answerQuestion(correct);

    expect(quiz.score, 10);
    expect(quiz.currentIndex, 1);
  });

  test('QuizProvider tidak menambah skor untuk jawaban salah', () async {
    final quiz = QuizProvider();
    final wrong = (quiz.questions[0].answerIndex + 1) % 4;

    await quiz.answerQuestion(wrong);

    expect(quiz.score, 0);
    expect(quiz.currentIndex, 1);
  });

  test('Rank sesuai skor kelipatan 10 dan semua tingkatan bisa dicapai', () {
    const palette = AppPalette.dark;

    expect(Rank.fromScore(0, palette).name, 'Soul Trainee');
    expect(Rank.fromScore(20, palette).name, 'Soul Trainee');
    expect(Rank.fromScore(30, palette).name, 'Soul Elder');
    expect(Rank.fromScore(50, palette).name, 'Soul Elder');
    expect(Rank.fromScore(60, palette).name, 'Soul Emperor');
    expect(Rank.fromScore(80, palette).name, 'Soul Emperor');
    expect(Rank.fromScore(90, palette).name, 'Titled Douluo');
    expect(Rank.fromScore(100, palette).name, 'God');
  });
}
