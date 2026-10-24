import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_colors.dart';
import '../utils/page_routes.dart';
import '../utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/app_background.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white),
                SizedBox(width: 12),
                Expanded(child: Text('Nama tidak boleh kosong!')),
              ],
            ),
          ),
        );
      return;
    }

    FocusScope.of(context).unfocus();
    final quiz = context.read<QuizProvider>();
    quiz.setUserName(name);
    quiz.startQuiz();
    Navigator.pushReplacement(
      context,
      fadeRoute(const QuizScreen(), duration: const Duration(milliseconds: 800)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    // Logo = 36% sisi terpendek layar (dibatasi 96 - 200)
    final logoSize = r.fromShortest(0.36, min: 96, max: 200);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AppBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: r.s(32)),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: r.contentWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.8, end: 1.0),
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    builder: (context, double scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          width: logoSize,
                          height: logoSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.gold, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gold.withOpacity(0.4 * scale),
                                blurRadius: logoSize * 0.28,
                                spreadRadius: logoSize * 0.07,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/logo_shrek.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: r.s(32)),
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1500),
                    builder: (context, double opacity, child) {
                      return Opacity(
                        opacity: opacity,
                        // FittedBox: judul selalu muat satu baris
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "SOUL LAND",
                            style: GoogleFonts.cinzel(
                              fontSize: r.s(48),
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                              letterSpacing: r.s(4),
                              shadows: const [
                                Shadow(color: AppColors.gold, blurRadius: 20),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: r.s(8)),
                  Text(
                    "10 Soal • Pilihan Ganda • ${QuizProvider.secondsPerQuestion} detik/soal",
                    style: GoogleFonts.poppins(
                      fontSize: r.s(12),
                      color: AppColors.textMuted,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: r.s(56)),
                  TextField(
                    controller: _nameController,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
                    onSubmitted: (_) => _startQuiz(),
                    style: GoogleFonts.poppins(
                      color: AppColors.textPrimary,
                      fontSize: r.s(16),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Nama Spirit Master',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.white38,
                        fontSize: r.s(16),
                      ),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: AppColors.gold,
                        size: r.s(24),
                      ),
                      filled: true,
                      fillColor: AppColors.bgMid.withOpacity(0.8),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: r.s(20)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(r.s(16)),
                        borderSide: BorderSide(
                          color: AppColors.gold.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(r.s(16)),
                        borderSide: const BorderSide(
                          color: AppColors.gold,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: r.s(32)),
                  CustomButton(
                    text: 'MULAI UJIAN',
                    icon: Icons.sports_martial_arts,
                    onPressed: _startQuiz,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}