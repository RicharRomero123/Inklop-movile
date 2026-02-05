import 'package:flutter/material.dart';
import 'verification_code_screen.dart'; // Asegúrate de tener esta pantalla creada

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  // Estados del flujo
  bool isCheckingPassword = false;
  bool _isPasswordVisible = false;

  // Variables de validación de contraseña
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(() => setState(() {}));
    _passwordFocus.addListener(() => setState(() {}));
  }

  void _validatePassword(String value) {
    setState(() {
      _hasMinLength = value.length >= 12;
      _hasUppercase = value.contains(RegExp(r'[A-Z]'));
      _hasNumber = value.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  // Lógica para habilitar el botón según el paso del flujo
  bool get _canContinue {
    if (!isCheckingPassword) {
      return _emailController.text.contains('@');
    } else {
      return _hasMinLength && _hasUppercase && _hasNumber && _hasSpecialChar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            if (isCheckingPassword) {
              setState(() => isCheckingPassword = false);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // 1. Icono de cabecera personalizado
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
                      'assets/images/icon_email_header.png',
                      height: 32,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 2. Títulos dinámicos
              Text(
                isCheckingPassword ? 'Ingresar con Email' : 'Continuar con Email',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Ingresa o regístrate con tu email',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // 3. Input Email (Se bloquea y muestra "Editar" en el paso 2)
              _buildTextField(
                controller: _emailController,
                focusNode: _emailFocus,
                hint: 'Dirección de Email',
                enabled: !isCheckingPassword,
                suffix: isCheckingPassword
                    ? TextButton(
                  onPressed: () => setState(() => isCheckingPassword = false),
                  child: const Text('Editar',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                )
                    : null,
                onChanged: (val) => setState(() {}),
              ),

              const SizedBox(height: 16),

              // 4. Input Password y Validadores (Paso 2)
              if (isCheckingPassword) ...[
                _buildTextField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  hint: 'Ingresa tu Contraseña',
                  obscureText: !_isPasswordVisible,
                  onChanged: _validatePassword,
                  suffix: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tu contraseña debe contener',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 12),
                      _buildValidatorRow('Al menos 12 caracteres', _hasMinLength),
                      _buildValidatorRow('Al menos 1 mayúscula', _hasUppercase),
                      _buildValidatorRow('Al menos 1 número', _hasNumber),
                      _buildValidatorRow('Al menos 1 caracter especial (#, !, /)', _hasSpecialChar),
                    ],
                  ),
                ),
              ],

              const Spacer(),

              // 5. Botón de Acción
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _canContinue
                      ? () {
                    if (!isCheckingPassword) {
                      setState(() => isCheckingPassword = true);
                    } else {
                      // Redirigir a OTP al cumplir validaciones
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VerificationCodeScreen()),
                      );
                    }
                  }
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    disabledBackgroundColor: const Color(0xFFF1F1F1),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Continuar',
                    style: TextStyle(
                      color: _canContinue ? Colors.white : const Color(0xFFADADAD),
                      fontSize: 16,
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

  // Widget para los campos de texto con bordes redondeados y dinámicos
  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    Widget? suffix,
    bool obscureText = false,
    bool enabled = true,
    Function(String)? onChanged,
  }) {
    bool isActive = focusNode.hasFocus || controller.text.isNotEmpty;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isActive ? const Color(0xFFE0E0E0) : const Color(0xFFF0F0F0),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        enabled: enabled,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFADADAD), fontSize: 15),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          suffixIcon: suffix,
        ),
      ),
    );
  }

  // Widget para las filas de validación de contraseña
  Widget _buildValidatorRow(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check : Icons.close,
            color: isValid ? Colors.green : Colors.red,
            size: 14,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: isValid ? Colors.green : Colors.red,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}