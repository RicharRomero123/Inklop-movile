import 'package:flutter/material.dart';
import '../../domain/dashboard_models.dart';

class VideoAnalyticsDialog extends StatefulWidget {
  final ContentModel content;

  const VideoAnalyticsDialog({super.key, required this.content});

  @override
  State<VideoAnalyticsDialog> createState() => _VideoAnalyticsDialogState();
}

// Estados del botón de cobro
enum PaymentStatus { initial, processing, paid }

class _VideoAnalyticsDialogState extends State<VideoAnalyticsDialog> {
  PaymentStatus _status = PaymentStatus.initial;

  void _handlePayment() {
    setState(() {
      _status = PaymentStatus.processing;
    });

    // Simulamos una petición de cobro de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _status = PaymentStatus.paid;
        });
        // Opcional: Cerrar el popup después de un tiempo
        // Future.delayed(const Duration(seconds: 1), () => Navigator.pop(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. HEADER (Badge y Cerrar)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(6)),
                  child: Text(widget.content.status, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.grey, size: 20),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Text('Analíticas del Video', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // 2. PREVIEW DEL VIDEO (Imagen Vertical)
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 280,
                    width: 180,
                    color: Colors.grey.shade300,
                    // Aquí iría tu imagen real: Image.asset(widget.content.thumbnailPath, fit: BoxFit.cover),
                    child: const Icon(Icons.play_arrow, size: 50, color: Colors.white54),
                  ),
                ),
                // Botón Link Flotante
                Transform.translate(
                  offset: const Offset(0, 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Link del Video', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Icon(Icons.open_in_new, color: Colors.white, size: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 3. INFO DEL USUARIO
            Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFFFF8A65), // Color dummy avatar
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Inklop Journey', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('Enviado el 14 Julio de 2025 a las 12:24 a.m', style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 4. CARDS DE MÉTRICAS
            Row(
              children: [
                Expanded(child: _buildMetricBox('Visualizaciones', widget.content.views, Icons.visibility)),
                const SizedBox(width: 12),
                Expanded(child: _buildMetricBox('Pago Acumulado', widget.content.earnings, Icons.attach_money)),
              ],
            ),

            const SizedBox(height: 24),

            // 5. BOTÓN DE ACCIÓN (ESTADOS)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: _buildActionButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricBox(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: Colors.green),
              const SizedBox(width: 4),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    switch (_status) {
      case PaymentStatus.initial:
        return FilledButton.icon(
          onPressed: _handlePayment,
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF1A1A1A), // Negro
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: const Icon(Icons.account_balance_wallet, size: 18, color: Colors.white),
          label: Text('Cobrar ${widget.content.earnings}', style: const TextStyle(fontWeight: FontWeight.bold)),
        );

      case PaymentStatus.processing:
        return FilledButton.icon(
          onPressed: null, // Deshabilitado
          style: FilledButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            disabledBackgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: const SizedBox(
            width: 14, height: 14,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.grey),
          ),
          label: const Text('Procesando Cobro', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        );

      case PaymentStatus.paid:
        return FilledButton.icon(
          onPressed: null, // Ya cobrado
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF388E3C), // Verde
            disabledBackgroundColor: const Color(0xFF388E3C), // Mantener verde aunque disabled
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          icon: const Icon(Icons.check_circle, size: 18, color: Colors.white),
          label: const Text('Cobrado', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        );
    }
  }
}