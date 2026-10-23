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
      text: 'Siapa nama karakter utama yang bereinkarnasi ke Benua Douluo?',
      options: ['Xiao Yan', 'Tang San', 'Lin Dong', 'Shi Hao'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: 'Selain Clear Sky Hammer, apa nama Spirit (Jiwa Bela Diri) asli milik Tang San?',
      options: ['Harimau Putih', 'Rumput Perak Biru', 'Sosis Unik', 'Phoenix Api'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: 'Siapa nama guru Tang San yang terkenal dengan penelitian teori kultivasi Spirit Master?',
      options: ['Flender', 'Zhao Wuji', 'Yu Xiaogang', 'Qian Xunji'],
      correctAnswerIndex: 2,
    ),
    Question(
      text: 'Apa nama akademi tempat Tujuh Iblis Shrek (Shrek Seven Devils) dibentuk?',
      options: ['Akademi Tiandou', 'Akademi Shrek', 'Akademi Wuhun', 'Akademi Bintang Luo'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: 'Siapa pahlawan wanita utama yang merupakan reinkarnasi dari Spirit Beast berusia 100.000 tahun?',
      options: ['Zhu Zhuqing', 'Ning Rongrong', 'Xiao Wu', 'Qian Renxue'],
      correctAnswerIndex: 2,
    ),
    Question(
      text: 'Apa nama senjata tersembunyi (Hidden Weapon) legendaris peninggalan Sekte Tang yang dikuasai Tang San?',
      options: ['Jarum Bunga Plum', 'Teratai Kemarahan Buddha', 'Panah Penembus Armor', 'Pisau Terbang'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: 'Siapa anggota Tujuh Iblis Shrek yang memiliki Spirit tipe pendukung berupa sosis?',
      options: ['Dai Mubai', 'Ma Hongjun', 'Oscar', 'Tang San'],
      correctAnswerIndex: 2,
    ),
    Question(
      text: 'Organisasi antagonis utama di benua Douluo yang memburu Spirit Beast berusia 100.000 tahun adalah?',
      options: ['Sekte Haotian', 'Spirit Hall', 'Sekte Kaca Berlapis 7', 'Sekte Naga Petir Biru'],
      correctAnswerIndex: 1,
    ),
    Question(
      text: 'Siapa nama ayah Tang San yang merupakan salah satu Titled Douluo termuda dan terkuat?',
      options: ['Tang Xiao', 'Tang Chen', 'Tang Hao', 'Tang San'],
      correctAnswerIndex: 2,
    ),
    Question(
      text: 'Pada Turnamen Elite Spirit Master tingkat Benua, siapa lawan terkuat Shrek di babak final?',
      options: ['Tim Akademi Tiandou', 'Tim Bintang Luo', 'Tim Generasi Emas Spirit Hall', 'Tim Gajah Berlapis Besi'],
      correctAnswerIndex: 2,
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