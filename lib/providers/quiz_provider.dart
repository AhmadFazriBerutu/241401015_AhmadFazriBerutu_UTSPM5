import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  static const int secondsPerQuestion = 20;
  static const Duration _feedbackDelay = Duration(milliseconds: 600);

  String _userName = '';
  int _score = 0;
  int _currentIndex = 0;
  bool _isFinished = false;

  int? _selectedOptionIndex;
  bool? _isCorrectAnswer;
  bool _isAnswerLocked = false;

  Timer? _timer;
  int _timeLeft = secondsPerQuestion;

  int _session = 0;

  final List<Question> _questions = [
    Question(text: 'Siapa nama roh bela diri pertama Tang San?', options: ['Blue Silver Grass', 'Clear Sky Hammer', 'White Tiger', 'Fire Phoenix'], answerIndex: 0),
    Question(text: 'Di mana Tang San pertama kali bertemu dengan Xiao Wu?', options: ['Akademi Shrek', 'Notting Academy', 'Spirit Hall', 'Star Luo Empire'], answerIndex: 1),
    Question(text: 'Apa gelar dari guru Tang San (Yu Xiaogang)?', options: ['Sword Douluo', 'Poison Douluo', 'Grandmaster', 'Bone Douluo'], answerIndex: 2),
    Question(text: 'Berapa jumlah cincin roh yang ideal untuk seorang Titled Douluo?', options: ['7', '8', '9', '10'], answerIndex: 2),
    Question(text: 'Roh bela diri apa yang dimiliki oleh Dai Mubai?', options: ['Evil Eye White Tiger', 'Sausage', 'Seven Treasure Glazed Tile', 'Hell Civet'], answerIndex: 0),
    Question(text: 'Apa nama sekte yang didirikan oleh Tang San?', options: ['Clear Sky Sect', 'Tang Sect', 'Seven Treasure Sect', 'Blue Lightning Sect'], answerIndex: 1),
    Question(text: 'Siapa nama ayah Tang San?', options: ['Tang Chen', 'Tang Hao', 'Tang Xiao', 'Tang San'], answerIndex: 1),
    Question(text: 'Hewan roh apa yang menjadi cincin roh pertama Tang San?', options: ['Datura Snake', 'Man Faced Demon Spider', 'Titan Ape', 'Sky Blue Bull Python'], answerIndex: 0),
    Question(text: 'Apa senjata tersembunyi terkuat yang dibuat Tang San di awal seri?', options: ['Dragon Whisker Needle', 'Buddha Fury Lotus', 'Godly Crossbow', 'Torrential Pear Blossom Needle'], answerIndex: 1),
    Question(text: 'Apa kemampuan roh bela diri sosis milik Oscar yang pertama?', options: ['Terbang', 'Pemulihan', 'Kekuatan', 'Kecepatan'], answerIndex: 1),
  ];

  String get userName => _userName;
  int get score => _score;
  int get currentIndex => _currentIndex;
  bool get isFinished => _isFinished;
  List<Question> get questions => _questions;
  int get timeLeft => _timeLeft;

  int? get selectedOptionIndex => _selectedOptionIndex;
  bool? get isCorrectAnswer => _isCorrectAnswer;
  bool get isAnswerLocked => _isAnswerLocked;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  /// Mulai kuis dari awal (dipakai tombol "Mulai Ujian" dan "Ulangi Ujian").
  void startQuiz() {
    _resetState();
    _startTimer();
    notifyListeners();
  }

  /// Kembalikan semua ke awal tanpa menjalankan timer.
  void resetQuiz() {
    _resetState();
    notifyListeners();
  }

  /// Jeda timer (mis. saat dialog keluar tampil).
  void pauseTimer() {
    _timer?.cancel();
  }

  /// Lanjutkan timer setelah dijeda.
  void resumeTimer() {
    if (_isFinished || _isAnswerLocked || _timeLeft <= 0) return;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  Future<void> answerQuestion(int index) => _submit(index);

  void _resetState() {
    _session++;
    _timer?.cancel();
    _score = 0;
    _currentIndex = 0;
    _isFinished = false;
    _selectedOptionIndex = null;
    _isCorrectAnswer = null;
    _isAnswerLocked = false;
    _timeLeft = secondsPerQuestion;
  }

  void _startTimer() {
    _timer?.cancel();
    _timeLeft = secondsPerQuestion;
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void _tick(Timer timer) {
    _timeLeft--;
    if (_timeLeft <= 0) {
      _timeLeft = 0;
      timer.cancel();
      _submit(null);
    } else {
      notifyListeners();
    }
  }

  Future<void> _submit(int? index) async {
    if (_isAnswerLocked || _isFinished) return;

    final session = _session;
    _timer?.cancel();
    _isAnswerLocked = true;
    _selectedOptionIndex = index;
    _isCorrectAnswer =
        index != null && _questions[_currentIndex].answerIndex == index;
    notifyListeners();

    HapticFeedback.lightImpact();

    if (_isCorrectAnswer!) {
      _score += 10;
    } else {
      HapticFeedback.vibrate();
    }

    await Future.delayed(_feedbackDelay);

    if (session != _session) return;

    _selectedOptionIndex = null;
    _isCorrectAnswer = null;
    _isAnswerLocked = false;

    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      _startTimer();
    } else {
      _isFinished = true;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}