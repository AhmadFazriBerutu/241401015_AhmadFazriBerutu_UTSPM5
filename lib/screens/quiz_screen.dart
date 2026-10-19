import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sedang Mengerjakan Kuis'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pertanyaan 1/5',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: Center(
                child: Text(
                  "Apa ibukota dari Indonesia?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            CustomButton(text: "A. Bandung", onPressed: () {}),
            const SizedBox(height: 12),
            CustomButton(text: "B. Jakarta", onPressed: () {}),
            const SizedBox(height: 12),
            CustomButton(text: "C. Surabaya", onPressed: () {}),
            const SizedBox(height: 12),
            CustomButton(text: "D. Medan", onPressed: () {}),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}