import 'package:flutter/material.dart';

class SearchResultItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? priceTag; // Opcional: Solo para campañas
  final bool isCampaign;  // Para saber si mostramos el precio

  const SearchResultItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.priceTag,
    this.isCampaign = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          // 1. Logo (Degradado Naranja/Rosado como en tu diseño)
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF8A65), Color(0xFFFF4081)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.info, color: Colors.white, size: 24),
            ),
          ),
          const SizedBox(width: 12),

          // 2. Textos (Título y Subtítulo)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),

          // 3. Tag de Precio (Solo si es campaña)
          if (isCampaign && priceTag != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A), // Negro
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                priceTag!,
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}