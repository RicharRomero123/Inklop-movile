import 'package:flutter/material.dart';
import 'widgets/register_bottom_sheet.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.1,
            colors: [
              Color(0xFF2B1255),
              Color(0xFF0D021D),
            ],
            stops: [0.2, 1.0],
          ),
        ),
        child: SafeArea(
          // 1. Quitamos el Padding general de aquí
          child: Column(
            children: [
              const Spacer(flex: 1),

              // 2. Imagen Hero: Sin Padding y con ancho completo
              SizedBox(
                width: double.infinity, // Ocupa todo el ancho
                child: Image.asset(
                  'assets/images/welcome_hero.png',
                  height: MediaQuery.of(context).size.height * 0.45,
                  // Usamos fitWidth para asegurar que toque los bordes laterales
                  // Si prefieres que se recorte arriba/abajo usa BoxFit.cover
                  fit: BoxFit.fitWidth,
                ),
              ),

              const Spacer(flex: 1),

              // 3. Agrupamos el contenido que SÍ lleva margen (Padding)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Logo Inklop
                    Image.asset(
                      'assets/images/logo_inklop.png',
                      height: 35,
                    ),

                    const SizedBox(height: 10),

                    // --- TEXTO CON DEGRADADO ---
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Color(0xFF9D5CDA),
                        ],
                      ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                      child: const Text(
                        'Where Everyone\nWins_',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Botón "Empezar" (También con Padding)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
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
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Empezar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Margen inferior manual
            ],
          ),
        ),
      ),
    );
  }
}