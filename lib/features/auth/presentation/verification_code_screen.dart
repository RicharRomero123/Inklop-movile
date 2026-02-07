import 'package:flutter/material.dart';
import 'birth_date_screen.dart'; //

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Escuchamos el foco para activar el cambio de color del borde dinámico
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _codeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isComplete = _codeController.text.length == 6;
    // El borde se resalta si el campo tiene el foco o ya tiene contenido
    bool isActive = _focusNode.hasFocus || _codeController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF8F8F8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 16),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // 1. Icono Header Circular
              Center(
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/icon_otp_header.png',
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 2. Títulos
              const Text(
                'Ingresa el Código de Verificación',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 10),

              // Correo resaltado en negro y negrita
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.4),
                  children: [
                    TextSpan(text: 'Enviamos un código de verificación a tu email\n'),
                    TextSpan(
                      text: 'cesarmesia.g@gmail.com',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // 3. Input de Código (CORREGIDO Y CENTRADO)
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 260,
                  height: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      // Borde dinámico según interacción
                      color: isActive ? const Color(0xFFE0E0E0) : const Color(0xFFF3F3F3),
                      width: 1.5,
                    ),
                  ),
                  child: TextField(
                    controller: _codeController,
                    focusNode: _focusNode,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center, // Centrado vertical
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    style: const TextStyle(
                      fontSize: 28,
                      letterSpacing: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.0, // Elimina espacios internos de la fuente
                    ),
                    decoration: const InputDecoration(
                      hintText: '------',
                      hintStyle: TextStyle(
                        color: Color(0xFFADADAD),
                        letterSpacing: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      border: InputBorder.none,
                      counterText: "",
                      // El padding compensa el letterSpacing para centrar horizontalmente
                      contentPadding: EdgeInsets.only(left: 14),
                    ),
                    onChanged: (value) => setState(() {}),
                  ),
                ),
              ),

              const Spacer(),

              // 4. Botón Verificar
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: isComplete
                      ? () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BirthDateScreen()),
                  )
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    disabledBackgroundColor: const Color(0xFFF1F1F1),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Verificar',
                    style: TextStyle(
                      color: isComplete ? Colors.white : const Color(0xFFADADAD),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
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