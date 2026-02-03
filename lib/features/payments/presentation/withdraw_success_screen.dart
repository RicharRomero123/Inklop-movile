import 'package:flutter/material.dart';

class WithdrawSuccessScreen extends StatelessWidget {
  final double amount;
  const WithdrawSuccessScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header Negro Curvo
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 80, bottom: 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF2D0052), Color(0xFF000000)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                  child: const Icon(Icons.check, color: Colors.white, size: 30),
                ),
                const SizedBox(height: 16),
                const Text('!Retiro Exitoso!', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Dentro de poco el dinero llegará a tu cuenta', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),

          const SizedBox(height: 40),

          Text('S/${amount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          const Text('El plazo de depósito es de 24 a 48 horas', style: TextStyle(color: Colors.grey)),

          const SizedBox(height: 40),

          // Tarjeta de Detalles
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 5))],
            ),
            child: Column(
              children: [
                const Text('Detalles de Transacción', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 16),
                const Divider(color: Colors.grey),
                const SizedBox(height: 16),
                _buildDetailRow('Campaña', 'Creadores Inklop'),
                _buildDetailRow('Método de Retiro', 'Tarjeta *****3456'),
                _buildDetailRow('Fecha', '15 de Noviembre, 2025'),
                _buildDetailRow('Hora', '9:41 AM'),
                _buildDetailRow('Nro de ref.', 'INK-2025-001356', isBold: true),
              ],
            ),
          ),

          const Spacer(),

          const Text('Gracias por confiar en Inklop', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('Sigue monetizando tu creatividad', style: TextStyle(fontSize: 10, color: Colors.grey)),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: () {
                  // Regresar hasta la Wallet (cerrando todo el stack de retiro)
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('Regresar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}