import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizProvider with ChangeNotifier {
  String _userName = '';
  int _score = 0;
  int _currentIndex = 0;

  String get userName => _userName;
  int get score => _score;
  int get currentIndex => _currentIndex;

  final List<Question> _questions = [
    Question(
      text: 'Apa framework UI buatan Google untuk membuat aplikasi lintas platform?',
      options: ['React Native', 'Flutter', 'Xamarin', 'Ionic'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: 'Bahasa pemrograman apa yang digunakan dalam pengembangan Flutter?',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctAnswerIndex: 2,
    ),
    Question(
      text: 'Widget mana yang digunakan jika tampilan tidak membutuhkan perubahan state?',
      options: ['StatefulWidget', 'StatelessWidget', 'InheritedWidget', 'MaterialApp'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: 'Perintah apa yang digunakan untuk menjalankan proyek Flutter di terminal?',
      options: ['flutter build', 'flutter run', 'flutter create', 'flutter doctor'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: 'File mana dalam proyek Flutter yang digunakan untuk menambahkan dependensi?',
      options: ['main.dart', 'pubspec.yaml', 'build.gradle', 'AndroidManifest.xml'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: 'Widget mana yang digunakan untuk menyusun elemen secara vertikal?',
      options: ['Row', 'Column', 'Stack', 'Container'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: 'Fungsi apa yang dipanggil untuk memperbarui tampilan pada StatefulWidget?',
      options: ['setState()', 'updateUI()', 'refresh()', 'rebuild()'],
      correctAnswerIndex: 0,
    ),
    Question(
      text: 'Widget apa yang menyediakan struktur dasar halaman Material Design?',
      options: ['Scaffold', 'Container', 'SizedBox', 'AppBar'],
      correctAnswerIndex: 0,
    ),
    Question(
      text: 'Komponen apa yang digunakan untuk menangkap teks input dari pengguna?',
      options: ['TextView', 'TextFormField', 'TextField', 'InputBox'],
      correctAnswerIndex: 2,
    ),
    Question(
      text: 'Perintah apa yang digunakan untuk memeriksa instalasi Flutter di komputer?',
      options: ['flutter check', 'flutter doctor', 'flutter test', 'flutter info'],
      correctAnswerIndex: 1,
    ),
  ];

  List<Question> get questions => _questions;
  bool get isFinished => _currentIndex >= _questions.length;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void answerQuestion(int selectedIndex) {
    if (_questions[_currentIndex].correctAnswerIndex == selectedIndex) {
      _score += 10;
    }
    _currentIndex++;
    notifyListeners();
  }

  void resetQuiz() {
    _score = 0;
    _currentIndex = 0;
    _userName = '';
    notifyListeners();
  }
}