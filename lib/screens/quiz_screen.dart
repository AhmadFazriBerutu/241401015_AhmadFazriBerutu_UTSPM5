import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String userName;

  const QuizScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': '1. Apa framework UI buatan Google untuk membuat aplikasi lintas platform?',
      'options': ['React Native', 'Flutter', 'Xamarin', 'Ionic']
    },
    {
      'question': '2. Bahasa pemrograman apa yang digunakan dalam pengembangan Flutter?',
      'options': ['Java', 'Kotlin', 'Dart', 'Swift']
    },
    {
      'question': '3. Widget mana yang digunakan jika tampilan tidak membutuhkan perubahan state?',
      'options': ['StatefulWidget', 'StatelessWidget', 'InheritedWidget', 'MaterialApp']
    },
    {
      'question': '4. Perintah apa yang digunakan untuk menjalankan proyek Flutter di terminal?',
      'options': ['flutter build', 'flutter run', 'flutter create', 'flutter doctor']
    },
    {
      'question': '5. File mana dalam proyek Flutter yang digunakan untuk menambahkan dependensi?',
      'options': ['main.dart', 'pubspec.yaml', 'build.gradle', 'AndroidManifest.xml']
    },
    {
      'question': '6. Widget mana yang digunakan untuk menyusun elemen secara vertikal?',
      'options': ['Row', 'Column', 'Stack', 'Container']
    },
    {
      'question': '7. Fungsi apa yang dipanggil untuk memperbarui tampilan pada StatefulWidget?',
      'options': ['setState()', 'updateUI()', 'refresh()', 'rebuild()']
    },
    {
      'question': '8. Widget apa yang menyediakan struktur dasar halaman Material Design?',
      'options': ['Scaffold', 'Container', 'SizedBox', 'AppBar']
    },
    {
      'question': '9. Komponen apa yang digunakan untuk menangkap teks input dari pengguna?',
      'options': ['TextView', 'TextFormField', 'TextField', 'InputBox']
    },
    {
      'question': '10. Perintah apa yang digunakan untuk memeriksa instalasi Flutter di komputer?',
      'options': ['flutter check', 'flutter doctor', 'flutter test', 'flutter info']
    },
  ];

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(userName: widget.userName),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQ = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Soal ${_currentIndex + 1} dari ${_questions.length}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (_currentIndex + 1) / _questions.length,
              backgroundColor: Colors.grey[200],
              color: Colors.indigo,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: Text(
                  currentQ['question'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ...List.generate(
              (currentQ['options'] as List<String>).length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: CustomButton(
                  text: (currentQ['options'] as List<String>)[index],
                  onPressed: _nextQuestion,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}