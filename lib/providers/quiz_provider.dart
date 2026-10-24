import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  int _score = 0;
  int _currentIndex = 0;
  bool _isFinished = false;
  
  int? _selectedOptionIndex;
  bool? _isCorrectAnswer;
  bool _isAnswerLocked = false;

  final List<Question> _questions = [
    Question(text: 'Siapa nama roh bela diri pertama Tang San?', options: ['Blue Silver Grass', 'Clear Sky Hammer', 'White Tiger', 'Fire Phoenix'], answerIndex: 0),
    Question(text: 'Di mana Tang San pertama kali bertemu dengan Xiao Wu?', options: ['Akademi Shrek', 'Notting Academy', 'Spirit Hall', 'Star Luo Empire'], answerIndex: 1),
    Question(text: 'Apa gelar dari guru Tang San (Yu Xiaogang)?', options: ['Sword Douluo', 'Poison Douluo', 'Grandmaster', 'Bone Douluo'], answerIndex: 2),
    Question(text: 'Berapa jumlah cincin roh yang ideal untuk seorang Titled Douluo?', options: ['7', '8', '9', '10'], answerIndex: 2),
    Question(text: 'Roh bela diri apa yang dimiliki oleh Dai Mubai?', options: ['Evil Eye White Tiger', 'Sausage', 'Seven Treasure Glazed Tile', 'Hell Civet'], answerIndex: 0),
    Question(text: 'Apa nama sekte yang didirikan oleh Tang San?', options: ['Clear Sky Sect', 'Tang Sect', 'Seven Treasure Sect', 'Blue Lightning Sect'], answerIndex: 1),
    Question(text: 'Siapa nama ayah Tang San?', options: ['Tang Chen', 'Tang Hao', 'Tang Xiao', 'Tang San'], answerIndex: 1),
    Question(text: 'Hewan roh apa yang menjadi cincin roh pertama Tang San?', options: ['Datura Snake', 'Man Faced Demon Spider', 'Titan Ape', 'Sky Blue Bull Python'], answerIndex: 0),
    Question(text: 'Apa senjata tersembunyi terkuat yang dibuat Tang San di awal seri?', options: ['Dragon须 Needle', 'Buddha Fury Lotus', 'Godly Crossbow', 'Torrential Pear Blossom Needle'], answerIndex: 1),
    Question(text: 'Apa kemampuan roh bela diri sosis milik Oscar yang pertama?', options: ['Terbang', 'Pemulihan', 'Kekuatan', 'Kecepatan'], answerIndex: 1),
  ];

  String get userName => _userName;
  int get score => _score;
  int get currentIndex => _currentIndex;
  bool get isFinished => _isFinished;
  List<Question> get questions => _questions;
  
  int? get selectedOptionIndex => _selectedOptionIndex;
  bool? get isCorrectAnswer => _isCorrectAnswer;
  bool get isAnswerLocked => _isAnswerLocked;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  Future<void> answerQuestion(int index) async {
    if (_isAnswerLocked) return;
    
    _isAnswerLocked = true;
    _selectedOptionIndex = index;
    _isCorrectAnswer = _questions[_currentIndex].answerIndex == index;
    notifyListeners();

    HapticFeedback.lightImpact();

    if (_isCorrectAnswer!) {
      _score += 10;
    } else {
      HapticFeedback.vibrate();
    }

    await Future.delayed(const Duration(milliseconds: 600));

    _selectedOptionIndex = null;
    _isCorrectAnswer = null;
    _isAnswerLocked = false;

    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
    } else {
      _isFinished = true;
    }
    notifyListeners();
  }

  void resetQuiz() {
    _score = 0;
    _currentIndex = 0;
    _isFinished = false;
    _selectedOptionIndex = null;
    _isCorrectAnswer = null;
    _isAnswerLocked = false;
    notifyListeners();
  }
}