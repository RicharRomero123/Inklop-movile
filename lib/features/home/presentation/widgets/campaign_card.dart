import 'package:flutter/material.dart';
import '../../domain/campaign_model.dart';
// Importa tu pantalla de detalle si la tienes
import 'package:inklop/features/auth/presentation/campaign_detail_screen.dart';

class CampaignCard extends StatelessWidget {
  final CampaignModel campaign;

  const CampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    // Calculamos el porcentaje de progreso
    final double progress = (campaign.paidAmount / campaign.totalBudget).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CampaignDetailScreen(campaign: campaign),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------------------------------------
            // 1. HEADER (Logo con FOTO, Título, Badge, Precio)
            // ---------------------------------------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LOGO DE LA MARCA (IMAGEN DESDE URL)
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade200),
                    image: DecorationImage(
                      // Usamos la URL que agregamos al modelo
                      image: NetworkImage(campaign.photoUrl),
                      fit: BoxFit.cover, // Para que llene el círculo
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Título y Badge "La más popular"
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      if (campaign.isPopular)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D2D2D), // Gris muy oscuro / Negro
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.local_fire_department_outlined, color: Colors.white, size: 12),
                              SizedBox(width: 4),
                              Text(
                                'La más popular',
                                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                // Tag de Precio
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    campaign.pricePerK,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ---------------------------------------------
            // 2. BARRA DE PROGRESO Y MONTOS
            // ---------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Monto Pagado
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontFamily: 'Segoe UI'),
                    children: [
                      TextSpan(
                        text: 'S/${campaign.paidAmount.toStringAsFixed(2)} ',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const TextSpan(
                        text: 'pagados',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                // Presupuesto Total
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.black, fontFamily: 'Segoe UI'),
                    children: [
                      const TextSpan(
                        text: 'de ',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      TextSpan(
                        text: 'S/${campaign.totalBudget.toStringAsFixed(2)} ',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const TextSpan(
                        text: 'presupuesto',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Barra de Progreso
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: const Color(0xFFF0F0F0),
                color: const Color(0xFF8E2DE2), // Morado Inklop
                minHeight: 8,
              ),
            ),

            const SizedBox(height: 24),

            // ---------------------------------------------
            // 3. FOOTER
            // ---------------------------------------------
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildFooterColumn('Tipo', campaign.type),
                ),
                Expanded(
                  child: _buildFooterColumn('Categoría', campaign.category),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Plataforma', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/ic_tiktok.png', width: 10, height: 10),
                        const SizedBox(width: 8),
                        Image.asset('assets/images/ic_instagram.png', width: 10, height: 10),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF1A1A1A)),
        ),
      ],
    );
  }
}