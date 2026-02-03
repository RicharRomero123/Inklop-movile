import 'package:flutter/material.dart';

class EditInterestsScreen extends StatefulWidget {
  const EditInterestsScreen({super.key});

  @override
  State<EditInterestsScreen> createState() => _EditInterestsScreenState();
}

class _EditInterestsScreenState extends State<EditInterestsScreen> {
  // Estado local para simular selección
  final List<String> _selectedInterests = [];

  // Método para manejar la selección
  void _toggleSelection(String label) {
    setState(() {
      if (_selectedInterests.contains(label)) {
        _selectedInterests.remove(label);
      } else {
        _selectedInterests.add(label);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SafeArea para evitar solapamientos
      body: SafeArea(
        child: Column(
          children: [
            // 1. CONTENIDO SCROLLABLE
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    // Botón Cerrar (Opcional, por si se abre como modal)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Avatar e Info
                    Container(
                      width: 80, height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person, size: 40, color: Colors.black),
                    ),
                    const SizedBox(height: 12),
                    const Text('@cesar.mesia', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),

                    const SizedBox(height: 24),
                    const Text('Sobre tus intereses', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text(
                      'Que es lo que te interesa más explorar en nuestra app?',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),

                    const SizedBox(height: 40),

                    // SECCIÓN 1: Intereses de Contenido
                    _buildSectionTitle('Intereses de Contenido'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildChip('Grabación de Contenido', Icons.videocam),
                        _buildChip('Clipping', Icons.content_cut),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // SECCIÓN 2: Tipo de Contenido
                    _buildSectionTitle('Tipo de Contenido'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12, // Espacio horizontal entre chips
                      runSpacing: 12, // Espacio vertical entre líneas
                      alignment: WrapAlignment.center,
                      children: [
                        _buildChip('Gaming', Icons.sports_esports),
                        _buildChip('Podcast', Icons.mic),
                        _buildChip('Education', Icons.school),
                        _buildChip('Foodie', Icons.restaurant),
                        _buildChip('Travels', Icons.flight),
                        _buildChip('Fashion', Icons.checkroom),
                        _buildChip('Beauty', Icons.brush),
                        _buildChip('Fitness', Icons.fitness_center),
                        _buildChip('Lifestyle', Icons.self_improvement),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // 2. BOTÓN FIJO AL FINAL
            Container(
              padding: const EdgeInsets.all(24),
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
                height: 55,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Aquí guardarías los cambios
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A), // Negro casi puro
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Continuar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }

  // Widget personalizado de Chip Seleccionable
  Widget _buildChip(String label, IconData icon) {
    final bool isSelected = _selectedInterests.contains(label);

    return GestureDetector(
      onTap: () => _toggleSelection(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : const Color(0xFFF5F5F5), // Negro si seleccionado, Gris suave si no
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : Colors.grey.shade600
            ),
            const SizedBox(width: 8),
            Text(
                label,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13
                )
            ),
          ],
        ),
      ),
    );
  }
}