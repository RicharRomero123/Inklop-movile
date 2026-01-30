import 'package:flutter/material.dart';

class MyCampaignCard extends StatelessWidget {
  final String title;
  final String brand;
  final String price;
  final bool isFinished; // Para cambiar el estilo si está finalizada

  const MyCampaignCard({
    super.key,
    required this.title,
    required this.brand,
    required this.price,
    this.isFinished = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 1. LOGO (Degradado Naranja/Rosado como en tu imagen)
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF8A65), Color(0xFFFF4081)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.info, color: Colors.white, size: 28), // Icono "i"
            ),
          ),
          const SizedBox(width: 16),

          // 2. INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  brand,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 6),
                // Tags pequeños
                Row(
                  children: [
                    _buildTag('Recomendación'),
                    const SizedBox(width: 4),
                    _buildTag('Tech'),
                    const SizedBox(width: 8),
                    // Iconos Plataformas
                    Icon(Icons.tiktok, size: 14, color: isFinished ? Colors.grey : Colors.black),
                    const SizedBox(width: 4),
                    Icon(Icons.camera_alt, size: 14, color: isFinished ? Colors.grey : Colors.black),
                  ],
                )
              ],
            ),
          ),

          // 3. PRECIO (Pill negra)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isFinished ? Colors.grey : const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              price,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
      ),
    );
  }
}