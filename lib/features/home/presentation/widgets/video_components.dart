import 'package:flutter/material.dart';

// --- SELECTOR DE RED SOCIAL ---
class SocialNetworkSelector extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelect;

  const SocialNetworkSelector({super.key, required this.selectedIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildChip(0, 'Tiktok', Icons.tiktok),
        const SizedBox(width: 12),
        _buildChip(1, 'Instagram', Icons.camera_alt),
      ],
    );
  }

  Widget _buildChip(int index, String label, IconData icon) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onSelect(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(label, style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Icon(icon, size: 16, color: isSelected ? Colors.black : Colors.white),
          ],
        ),
      ),
    );
  }
}

// --- SELECTOR DE CUENTA (HORIZONTAL) ---
class AccountSelector extends StatelessWidget {
  final VoidCallback onAddAccount;

  const AccountSelector({super.key, required this.onAddAccount});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // CUENTA SELECCIONADA
          Column(
            children: [
              Container(
                width: 70, height: 70,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(18),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/role_content.png'), // Tu placeholder
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text('lui.peps', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
          const SizedBox(width: 16),

          // BOTÓN AÑADIR CUENTA
          GestureDetector(
            onTap: onAddAccount,
            child: Column(
              children: [
                Container(
                  width: 70, height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 30),
                ),
                const SizedBox(height: 8),
                const Text('Añadir Cuenta', style: TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- GRID DE VIDEOS ---
class VideoGrid extends StatefulWidget {
  const VideoGrid({super.key});

  @override
  State<VideoGrid> createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {
  int? _selectedVideoIndex;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(), // No scrollea solo
      shrinkWrap: true, // Ocupa solo lo necesario
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.6, // Formato vertical (TikTok)
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        bool isSelected = _selectedVideoIndex == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedVideoIndex = index),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(12),
              border: isSelected ? Border.all(color: const Color(0xFF5E17EB), width: 3) : null,
              // Aquí iría la imagen real del video
              // image: DecorationImage(...)
            ),
            child: Stack(
              children: [
                // Placeholder de imagen
                const Center(child: Icon(Icons.play_arrow, color: Colors.white38, size: 30)),

                // Duración / Tiempo atrás
                Positioned(
                  bottom: 8, left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
                    child: const Row(
                      children: [
                        Icon(Icons.history, size: 10, color: Colors.white),
                        SizedBox(width: 4),
                        Text('Hace 4 min', style: TextStyle(color: Colors.white, fontSize: 8)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}