import 'package:flutter/material.dart';
import 'package:inklop/features/auth/presentation/main_screen.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final Set<String> _selectedInterests = {'Gaming', 'Lifestyle'};
  final List<String> _contentInterests = ['Grabación de Contenido', 'Clipping'];
  final List<String> _typeInterests = ['Gaming', 'Podcast', 'Education', 'Foodie', 'Travels', 'Fashion', 'Beauty', 'Fitness', 'Lifestyle'];

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
            // Usamos pushAndRemoveUntil para que el usuario no pueda volver al registro dando "Atrás"
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const MainScreen()),
                    (route) => false // Borra todo el historial de navegación anterior
            );
          },
        ),

      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1. ZONA SCROLL
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
                    const SizedBox(height: 10),
                    const Text('@cesar.mesia', style: TextStyle(fontSize: 14)),
                    const SizedBox(height: 5),
                    const Text('Sobre tus intereses', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text(
                      'Que es lo que te interesa más explorar en nuestra app?',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text('Intereses de Contenido', style: TextStyle(fontSize: 14, color: Colors.black87)),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _contentInterests.map((interest) => _buildChip(interest)).toList(),
                    ),

                    const SizedBox(height: 24),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text('Tipo de Contenido', style: TextStyle(fontSize: 14, color: Colors.black87)),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _typeInterests.map((interest) => _buildChip(interest)).toList(),
                    ),

                    const SizedBox(height: 20), // Margen final
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
                height: 56, // Misma altura
                child: FilledButton(
                  onPressed: () {
                    // TODO: Finalizar registro (Ir al Home)
                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
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

  Widget _buildChip(String label) {
    final isSelected = _selectedInterests.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedInterests.remove(label);
          } else {
            _selectedInterests.add(label);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A1A) : const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Aquí puedes poner lógica para cambiar iconos según el interés si deseas
            Icon(
              Icons.interests,
              size: 16,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}