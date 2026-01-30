import 'package:flutter/material.dart';
import 'package:inklop/features/auth/presentation/campaign_detail_screen.dart';
import '../../domain/campaign_model.dart';
// IMPORTANTE: Importamos la pantalla de detalle para poder navegar

class CampaignCard extends StatelessWidget {
  final CampaignModel campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    // Calculamos el porcentaje para la barra de progreso
    final double progress = campaign.paidAmount / campaign.totalBudget;

    // 1. ENVOLVEMOS TODO EN GESTUREDETECTOR
    return GestureDetector(
      onTap: () {
        // Navegamos al detalle enviando la campaña seleccionada
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CampaignDetailScreen(campaign: campaign),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER (Logo, Titulo, Precio)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo Simulado (Círculo con letra)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(campaign.colorCode).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      campaign.brandName[0], // Primera letra
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(campaign.colorCode)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Título y Badge
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      if (campaign.isPopular)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_fire_department, color: Colors.white, size: 10),
                              SizedBox(width: 4),
                              Text(
                                'La más popular',
                                style: TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                // Precio Tag (Negro)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    campaign.pricePerK,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 2. PROGRESS BAR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('S/${campaign.paidAmount.toStringAsFixed(2)} pagados', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Text('de S/${campaign.totalBudget.toStringAsFixed(2)} presupuesto', style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                color: Color(campaign.colorCode), // Color de la marca
                minHeight: 6,
              ),
            ),

            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            const SizedBox(height: 12),

            // 3. FOOTER (Detalles)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailItem('Tipo', campaign.type),
                _buildDetailItem('Categoría', campaign.category),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Plataforma', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.tiktok, size: 16),
                        SizedBox(width: 4),
                        Icon(Icons.camera_alt, size: 16), // Simula Instagram
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}