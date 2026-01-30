import 'package:flutter/material.dart';
import 'widgets/video_components.dart'; // Los componentes visuales
import 'widgets/link_account_sheets.dart'; // Los modals

class SendVideoScreen extends StatefulWidget {
  const SendVideoScreen({super.key});

  @override
  State<SendVideoScreen> createState() => _SendVideoScreenState();
}

class _SendVideoScreenState extends State<SendVideoScreen> {
  int _selectedNetwork = 0; // 0: Tiktok, 1: Instagram

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D), // Fondo Negro (Casi negro)
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Enviar Video', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. SELECCIONAR RED SOCIAL
                    const Text('Selecciona una red social', style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 16),
                    SocialNetworkSelector(
                      selectedIndex: _selectedNetwork,
                      onSelect: (index) => setState(() => _selectedNetwork = index),
                    ),

                    const SizedBox(height: 30),

                    // 2. SELECCIONAR CUENTA
                    const Text('Seleccionar Cuenta', style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 16),
                    AccountSelector(
                      onAddAccount: () {
                        // FLUJO DE VINCULACIÓN:
                        // 1. Mostrar Sheet de URL
                        showLinkAccountSheet(context, () {
                          // 2. Al darle "Añadir", esperar un poco y mostrar Sheet de Verificación
                          Future.delayed(const Duration(milliseconds: 300), () {
                            showVerificationSheet(context);
                          });
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    // ALERTA
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, color: Colors.grey, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Solo se mostrarán los videos subidos en los últimos 30 minutos. Asegúrate que el video se haya subido completamente a Tiktok en modo público',
                            style: TextStyle(color: Colors.grey.shade400, fontSize: 12, height: 1.4),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // 3. SELECCIONAR VIDEO (GRID)
                    const Text('Seleccionar Video', style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(height: 16),
                    const VideoGrid(),

                    const SizedBox(height: 80), // Espacio para el botón flotante
                  ],
                ),
              ),
            ),

            // BOTÓN FINAL
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF0D0D0D),
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    // Lógica de envío final
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Video enviado a revisión')));
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white24, // Gris deshabilitado o blanco si está listo
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Seleccionar y Enviar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}