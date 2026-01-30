import 'package:flutter/material.dart';

// 1. IMPORTANTE: Importamos la pantalla real que creamos antes.
// Los dos puntos (..) significan "salir de la carpeta widgets e ir a la carpeta anterior"
import '../login_email_screen.dart';

class RegisterBottomSheet extends StatelessWidget {
  const RegisterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      height: 450,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.grey),
              style: IconButton.styleFrom(backgroundColor: Colors.grey.shade100),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Image.asset('assets/images/logo_small.png', height: 24),
          ),
          const SizedBox(height: 20),
          const Text(
            'Empieza Ahora',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            'Regístrate para empezar a monetizar tu creatividad o crear campañas y monitorear tu alcance',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5),
          ),
          const Spacer(),

          // --- AQUÍ ESTÁ EL CAMBIO DE CONEXIÓN ---
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el menú flotante

                // 2. Navega a la pantalla LoginEmailScreen REAL
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginEmailScreen())
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A1A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Continuar con Email', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            ),
          ),
          // ----------------------------------------

          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _SocialButton(iconPath: 'assets/images/google_icon.png', onTap: () {})),
              const SizedBox(width: 16),
              Expanded(child: _SocialButton(iconPath: 'assets/images/apple_icon.png', onTap: () {})),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onTap;
  const _SocialButton({required this.iconPath, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(14),
        child: Image.asset(iconPath, fit: BoxFit.contain),
      ),
    );
  }
}

// NOTA: He borrado la clase LoginScreen que estaba aquí abajo
// porque ya existe el archivo real.