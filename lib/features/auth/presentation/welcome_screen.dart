import 'package:flutter/material.dart';
import 'widgets/register_bottom_sheet.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ya no necesitamos el backgroundColor plano porque usaremos un Container con gradiente
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // --- AQUÍ ESTÁ EL DEGRADADO ---
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF372065), // Morado vibrante (arriba)
              Color(0xFF9D5CDA), // Morado/Magenta (abajo)
              // Puedes cambiar estos códigos HEX por los exactos de tu diseño
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: Column(
              children: [
                const Spacer(flex: 1),

                // Imagen Hero (Asegúrate que sea una imagen con fondo transparente/PNG)
                Image.asset(
                  'assets/images/welcome_hero.png',
                  height: 350,
                  fit: BoxFit.contain,
                ),

                const Spacer(flex: 1),

                // Logo Inklop
                // Si tu logo es negro, quizás necesites aplicarle color blanco:
                Image.asset(
                  'assets/images/logo_inklop.png',
                  height: 40,
                  // color: Colors.white, // <-- DESCOMENTA ESTO SI TU LOGO ES NEGRO
                ),

                const SizedBox(height: 16),

                // Texto Principal
                const Text(
                  'Where patoEveryone\nWins_',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white, // <-- CAMBIADO A BLANCO PARA CONTRASTE
                    height: 1.2,
                    fontFamily: 'Segoe UI',
                  ),
                ),

                const Spacer(flex: 2),

                // Botón "Empezar"
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
                      // Puedes mantenerlo negro o cambiarlo a blanco si prefieres más contraste
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
      ),
    );
  }
}