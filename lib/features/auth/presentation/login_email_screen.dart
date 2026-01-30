import 'package:flutter/material.dart';
import 'verification_code_screen.dart'; // Importamos la siguiente pantalla

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Variables de validación
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  void _validatePassword(String value) {
    setState(() {
      _hasMinLength = value.length >= 12;
      _hasUppercase = value.contains(RegExp(r'[A-Z]'));
      _hasNumber = value.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  bool get _isFormValid => _hasMinLength && _hasUppercase && _hasNumber && _hasSpecialChar && _emailController.text.isNotEmpty;

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
              // 1. Icono Superior
              Center(
                child: Container(
                  height: 60,
                  width: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/icon_email_header.png'),
                ),
              ),
              const SizedBox(height: 20),

              // 2. Títulos
              const Text(
                'Ingresar con Email',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ingresa o regístrate con tu email',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // 3. Input Email
              _buildTextField(
                controller: _emailController,
                hint: 'cesarmesia.g@gmail.com',
                suffix: TextButton(
                  onPressed: () {}, // Lógica para editar si se requiere
                  child: const Text('Editar', style: TextStyle(color: Colors.blue)),
                ),
              ),
              const SizedBox(height: 16),

              // 4. Input Password
              _buildTextField(
                controller: _passwordController,
                hint: 'Ingresa tu Contraseña',
                obscureText: !_isPasswordVisible,
                onChanged: _validatePassword,
                suffix: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
              const SizedBox(height: 20),

              // 5. Validaciones de Contraseña
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tu contraseña debe contener', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    const SizedBox(height: 8),
                    _buildValidatorRow('Al menos 12 caracteres', _hasMinLength),
                    _buildValidatorRow('Al menos 1 mayúscula', _hasUppercase),
                    _buildValidatorRow('Al menos 1 número', _hasNumber),
                    _buildValidatorRow('Al menos 1 caracter especial (#, !, /)', _hasSpecialChar),
                  ],
                ),
              ),

              const Spacer(),

              // 6. Botón Continuar
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _isFormValid
                      ? () {
                    // Navegar a la siguiente pantalla
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const VerificationCodeScreen()));
                  }
                      : null, // Deshabilitado si no cumple requisitos
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    disabledBackgroundColor: Colors.grey.shade200,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    'Continuar',
                    style: TextStyle(
                      color: _isFormValid ? Colors.white : Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

  // Widget auxiliar para los inputs
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    Widget? suffix,
    bool obscureText = false,
    Function(String)? onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          suffixIcon: suffix,
        ),
      ),
    );
  }

  // Widget auxiliar para las filas de validación (Rojo/Verde)
  Widget _buildValidatorRow(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check : Icons.close,
            color: isValid ? Colors.green : Colors.red,
            size: 14,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isValid ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}