import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Default gelap (sesuai tema Soul Land).
  // Ganti ke ThemeMode.system untuk mengikuti pengaturan perangkat.
  ThemeMode _mode = ThemeMode.dark;

  ThemeMode get mode => _mode;

  void setMode(ThemeMode mode) {
    if (mode == _mode) return;
    _mode = mode;
    notifyListeners();
  }
}