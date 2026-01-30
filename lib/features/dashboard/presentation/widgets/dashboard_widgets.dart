import 'package:flutter/material.dart';
import '../../domain/dashboard_models.dart';
import 'video_analytics_dialog.dart'; // <--- IMPORTANTE: Importar el diálogo

// 1. TARJETA DE MÉTRICA (Las 3 de arriba)
class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const MetricCard({super.key, required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Ancho fijo para que se vean uniformes
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: Colors.black),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Colors.grey, height: 1.2),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

// 2. TARJETA DE CAMPAÑA ACTIVA (Compacta)
class CompactCampaignCard extends StatelessWidget {
  const CompactCampaignCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          // Logo
          Container(
            width: 48, height: 48,
            decoration: const BoxDecoration(color: Color(0xFFD32F2F), shape: BoxShape.circle),
            child: const Center(child: Text('T', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24))),
          ),
          const SizedBox(width: 12),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Navidad con Topitop', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const Text('@topitop.pe', style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildTag('Recomendación'),
                    const SizedBox(width: 4),
                    _buildTag('Tech'),
                    const SizedBox(width: 8),
                    const Icon(Icons.tiktok, size: 14),
                    const SizedBox(width: 4),
                    const Icon(Icons.camera_alt, size: 14),
                  ],
                )
              ],
            ),
          ),
          // Precio
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(8)),
            child: const Text('S/20/1K', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: const TextStyle(fontSize: 10, color: Colors.grey)),
    );
  }
}

// 3. TARJETA DE CONTENIDO (Video - Con Click)
class ContentItemCard extends StatelessWidget {
  final ContentModel content;

  const ContentItemCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    // 1. ENVOLVER EN GESTUREDETECTOR PARA EL POPUP
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => VideoAnalyticsDialog(content: content),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          children: [
            // Thumbnail del Video (Simulado)
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                // Aquí usarías: image: DecorationImage(image: AssetImage(content.thumbnailPath), fit: BoxFit.cover),
              ),
              child: Stack(
                children: [
                  const Center(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 40)),
                  Positioned(
                    top: 10, right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)),
                      child: Text(content.status, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),

            // Info del Video
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.tiktok, size: 20), // Icono Plataforma
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          content.caption,
                          style: const TextStyle(fontSize: 13, height: 1.3),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Métricas Pequeñas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStat(Icons.remove_red_eye_outlined, content.views),
                      _buildStat(Icons.favorite_border, content.likes),
                      _buildStat(Icons.chat_bubble_outline, content.comments),
                      _buildStat(Icons.share_outlined, content.shares),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Botón Ganancia
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(content.earnings, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                        const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// 4. FILTRO DE TABS (Pill shaped)
class ContentFilterTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ContentFilterTab({super.key, required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A1A) : Colors.transparent, // Negro si seleccionado
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}