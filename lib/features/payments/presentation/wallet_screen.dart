import 'package:flutter/material.dart';
import 'withdraw_screen.dart'; // <--- IMPORTANTE: Importar la pantalla de retiro

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // Variable para simular si ya conectaste Stripe
  bool _isStripeConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D), // Fondo Negro
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Mi Billetera', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Balance Total', style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 8),
            const Text('S/1,025.00', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),

            const SizedBox(height: 30),

            // BOTÓN VERIFICAR IDENTIDAD (Solo visible si no está conectado o verificado)
            if (!_isStripeConnected) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Center(
                  child: Text('Verifica tu Identidad', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],

            // --- LÓGICA DE ESTADO: VINCULAR vs RETIRAR ---
            if (!_isStripeConnected)
            // ESTADO 1: NO VINCULADO (Muestra Card de Stripe)
              _buildStripeLinkCard()
            else
            // ESTADO 2: VINCULADO (Muestra Botón de Retiro)
              _buildWithdrawButton(),

            const SizedBox(height: 40),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Mis Retiros', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isStripeConnected) ...[
                      // Ejemplo visual de historial vacío o transacción reciente simulada
                      const Icon(Icons.history, color: Colors.grey, size: 40),
                      const SizedBox(height: 10),
                    ],
                    const Text('No se Realizaron Retiros', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET: TARJETA DE VINCULACIÓN ---
  Widget _buildStripeLinkCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D0052), Color(0xFF000000)], // Degradado sutil morado a negro
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF635BFF), borderRadius: BorderRadius.circular(8)),
                child: const Text('S', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Vincula una cuenta de Stripe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    SizedBox(height: 4),
                    Text(
                      'Necesitas vincular y verificar tu cuenta para comenzar a recibir pagos',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => _showStripeModal(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Conectar Ahora', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET: BOTÓN DE RETIRO (NUEVO) ---
  Widget _buildWithdrawButton() {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          // NAVEGACIÓN A PANTALLA DE RETIRO
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const WithdrawScreen(currentBalance: 1025.00)),
          );
        },
        style: FilledButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text('Retirar Fondos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  // --- MODAL DE VINCULACIÓN STRIPE ---
  void _showStripeModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.info, color: Colors.black, size: 24),
                  ),
                  Transform.translate(
                    offset: const Offset(-10, 10),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFF635BFF), borderRadius: BorderRadius.circular(12)),
                      child: const Text('S', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text('Vincular Stripe', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text(
                'Vincula tu cuenta de Stripe de forma segura para recibir pagos directamente.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    // SIMULACIÓN: CAMBIAR ESTADO A CONECTADO
                    Navigator.pop(context); // Cerrar modal
                    setState(() {
                      _isStripeConnected = true; // <--- ESTO ACTIVA EL BOTÓN DE RETIRO
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('¡Cuenta de Stripe vinculada exitosamente!'),
                          backgroundColor: Colors.green,
                        )
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Conectar Ahora', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}