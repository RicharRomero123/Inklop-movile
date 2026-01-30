import 'package:flutter/material.dart';
import 'business_profile_screen.dart'; // Camino A
import 'creator_profile_screen.dart';  // Camino B

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  // 0 = Ninguno, 1 = Campañas (Business), 2 = Contenido (Creator)
  int _selectedRole = 0;

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
            // 1. ZONA SCROLL (Contenido)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Icono cabecera
                    Center(
                      child: Container(
                        height: 60,
                        width: 60,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3F3F3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.supervised_user_circle_outlined, color: Colors.black, size: 30),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Define tu rol',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Elije el rol que tomarás en la aplicación (no se podrá revertir)',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),

                    // --- OPCIÓN 1: CAMPAÑAS ---
                    _buildRoleCard(
                      value: 1,
                      title: 'Crear Campañas',
                      subtitle: 'Marcas o Streamers',
                      imagePath: 'assets/images/role_campaigns.png',
                    ),

                    const SizedBox(height: 20),

                    // --- OPCIÓN 2: CONTENIDO ---
                    _buildRoleCard(
                      value: 2,
                      title: 'Crear Contenido',
                      subtitle: 'Creadores o Clippers',
                      imagePath: 'assets/images/role_content.png',
                    ),

                    const SizedBox(height: 20), // Margen final del scroll
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
                height: 56,
                child: FilledButton(
                  onPressed: _selectedRole != 0
                      ? () {
                    if (_selectedRole == 1) {
                      // Ir a Perfil de Empresa
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const BusinessProfileScreen()));
                    } else {
                      // Ir a Perfil de Creador
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CreatorProfileScreen()));
                    }
                  }
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    disabledBackgroundColor: const Color(0xFFF3F3F3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    'Continuar',
                    style: TextStyle(
                        color: _selectedRole != 0 ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required int value,
    required String title,
    required String subtitle,
    required String imagePath
  }) {
    final isSelected = _selectedRole == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = value),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A1A) : const Color(0xFFF9F9F9), // Negro si seleccionado
          borderRadius: BorderRadius.circular(24),
          border: isSelected ? null : Border.all(color: Colors.transparent),
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 100, fit: BoxFit.contain),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black, // Texto blanco si seleccionado
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white70 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}