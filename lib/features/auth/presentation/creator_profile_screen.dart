import 'package:flutter/material.dart';
import 'interests_screen.dart'; // Asegúrate de importar la siguiente pantalla

class CreatorProfileScreen extends StatelessWidget {
  const CreatorProfileScreen({super.key});

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
        child: Column(
          children: [
            // 1. ZONA DE SCROLL (Formulario)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: 80,
                        width: 80,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(color: Color(0xFFF3F3F3), shape: BoxShape.circle),
                        child: const Icon(Icons.person, size: 40, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Completa Tu Perfil', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text(
                      'Date a conocer a otros creadores y la comunidad Inklop',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),

                    _buildInput(label: 'Nombre de usuario', hint: '@username'),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(child: _buildInput(label: 'Nombre', hint: 'Nombre')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildInput(label: 'Apellido', hint: 'Apellido')),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Bio', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(height: 8),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(16)),
                          child: const TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'Comparte algo curioso sobre ti',
                              hintStyle: TextStyle(color: Colors.black26),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(child: _buildInput(label: 'País', hint: 'Selecciona tu país')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildInput(label: 'Ciudad', hint: 'Ciudad')),
                      ],
                    ),

                    // Espacio extra al final para que el último campo no quede pegado al botón
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // 2. ZONA FIJA (Botón)
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56, // Misma altura que en BusinessProfile
                child: FilledButton(
                  onPressed: () {
                    // Navega a la pantalla de Intereses
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const InterestsScreen()));
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Continuar', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(30)),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black26),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}