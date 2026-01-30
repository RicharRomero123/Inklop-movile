import 'package:flutter/material.dart';
import 'widgets/register_bottom_sheet.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
          child: Column(
            children: [
              const Spacer(flex: 1),
              Image.asset(
                'assets/images/welcome_hero.png',
                height: 350,
                fit: BoxFit.contain,
              ),
              const Spacer(flex: 1),
              Image.asset(
                'assets/images/logo_inklop.png',
                height: 40,
              ),
              const SizedBox(height: 16),
              const Text( // <-- Usamos Text normal
                'Where Everyone\nWins_',
                textAlign: TextAlign.center,
                style: TextStyle( // <-- TextStyle estándar
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.2,
                  fontFamily: 'Segoe UI', // Fuente por defecto en Windows o sistema
                ),
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const RegisterBottomSheet(),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Empezar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}