import 'package:flutter/material.dart';
import 'birth_date_screen.dart'; // Importamos la siguiente pantalla

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // 1. Icono Header
              Center(
                child: Container(
                  height: 60,
                  width: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/icon_otp_header.png'),
                ),
              ),
              const SizedBox(height: 20),

              // 2. Títulos
              const Text(
                'Ingresa el Código de Verificación',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Enviamos un código de verificación a tu email\ncesarmesia.g@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // 3. Input de Código (Estilizado como la imagen)
              Container(
                width: 250,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _codeController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 6, // Máximo 6 dígitos
                  style: const TextStyle(fontSize: 24, letterSpacing: 8, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    hintText: '- - - - - -',
                    border: InputBorder.none,
                    counterText: "", // Oculta el contador de caracteres
                  ),
                  onChanged: (value) {
                    setState(() {}); // Para actualizar el botón
                  },
                ),
              ),

              const Spacer(),

              // 4. Botón Verificar
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _codeController.text.length == 6
                      ? () {
                    // Navegar a Fecha de Nacimiento
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BirthDateScreen()));
                  }
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    disabledBackgroundColor: const Color(0xFFF3F3F3), // Gris si está deshabilitado
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    'Verificar',
                    style: TextStyle(
                        color: _codeController.text.length == 6 ? Colors.white : Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
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