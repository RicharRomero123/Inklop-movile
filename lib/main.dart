import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // 1. Importa la librería
import 'features/auth/presentation/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inklop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF1A1A1A),

        // 2. Configuramos la tipografía global aquí
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ).apply(
          // Esto aplica el espaciado que quieres a TODOS los textos
          letterSpacingDelta: -0.05,
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}