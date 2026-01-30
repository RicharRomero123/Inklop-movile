import 'package:flutter/material.dart';
import 'features/auth/presentation/welcome_screen.dart'; // Asegúrate que esta ruta exista

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
        // Tu color negro suave
        colorSchemeSeed: const Color(0xFF1A1A1A),
      ),
      // Carga directa de tu pantalla de diseño
      home: const WelcomeScreen(),
    );
  }
}