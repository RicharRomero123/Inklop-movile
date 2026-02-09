import 'package:flutter/material.dart';

// --- RESTAURAMOS TU IMPORT ORIGINAL PARA LA FUNCIÓN DE AÑADIR CUENTA ---
import 'widgets/link_account_sheets.dart';

class SendVideoScreen extends StatefulWidget {
  const SendVideoScreen({super.key});

  @override
  State<SendVideoScreen> createState() => _SendVideoScreenState();
}

class _SendVideoScreenState extends State<SendVideoScreen> {
  // Estados de selección
  int _selectedNetworkIndex = 0; // 0: Tiktok, 1: Instagram
  int _selectedAccountIndex = 0; // -1 si no hay selección, 0 por defecto
  int _selectedVideoIndex = -1;  // -1: Ninguno seleccionado

  // Datos Dummy para la demo visual de los videos
  final List<String> _dummyVideos = [
    'assets/images/video_thumb_1.png',
    'assets/images/video_thumb_2.png',
    'assets/images/video_thumb_3.png',
  ];

  @override
  Widget build(BuildContext context) {
    // Calculamos si el botón principal debe estar activo (Solo si hay un video seleccionado)
    final bool canProceed = _selectedVideoIndex != -1;

    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro puro
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Enviar Video', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. SELECCIONAR RED SOCIAL
                    const Text('Selecciona una red social', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildNetworkChip(0, 'Tiktok', Icons.music_note),
                        const SizedBox(width: 12),
                        _buildNetworkChip(1, 'Instagram', Icons.camera_alt),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // 2. SELECCIONAR CUENTA
                    const Text('Seleccionar Cuenta', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildAccountItem(0, 'lui.peps', Colors.grey[800]!),
                          const SizedBox(width: 12),
                          // BOTÓN AÑADIR CUENTA CON TU LÓGICA RESTAURADA
                          _buildAddAccountButton(),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ALERTA INFO
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline, color: Colors.grey[600], size: 18),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Solo se mostrarán los videos subidos en los últimos 30 minutos. Asegúrate que el video se haya subido completamente a Tiktok en modo público',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12, height: 1.4),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // 3. SELECCIONAR VIDEO (GRID)
                    const Text('Seleccionar Video', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.65, // Aspect ratio vertical tipo TikTok
                      ),
                      itemCount: _dummyVideos.length,
                      itemBuilder: (context, index) {
                        return _buildVideoItem(index);
                      },
                    ),

                    const SizedBox(height: 100), // Espacio extra al final para que no lo tape el botón
                  ],
                ),
              ),
            ),

            // BOTÓN FLOTANTE INFERIOR ("Seleccionar")
            Container(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
              decoration: const BoxDecoration(
                color: Colors.black,
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: canProceed
                      ? () => _showDisclaimerModal(context) // Abre el modal de términos
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: canProceed ? Colors.white : const Color(0xFF2C2C2C),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                      'Seleccionar',
                      style: TextStyle(
                          color: canProceed ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS DE UI ---

  // Chip de Red Social (Tiktok / Instagram)
  Widget _buildNetworkChip(int index, String label, IconData icon) {
    bool isSelected = _selectedNetworkIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedNetworkIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 1
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? Colors.black : Colors.white),
            const SizedBox(width: 8),
            Text(
                label,
                style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                )
            ),
          ],
        ),
      ),
    );
  }

  // Item de Cuenta Seleccionable
  Widget _buildAccountItem(int index, String name, Color placeholderColor) {
    bool isSelected = _selectedAccountIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedAccountIndex = index),
      child: Container(
        width: 100, height: 100,
        decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(20),
            // BORDE BLANCO SI ESTÁ SELECCIONADO
            border: Border.all(
                color: isSelected ? Colors.white : Colors.transparent,
                width: 2
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: placeholderColor, radius: 20),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // Botón "Añadir Cuenta" (CON TU LÓGICA RESTAURADA)
  Widget _buildAddAccountButton() {
    return GestureDetector(
      onTap: () {
        // --- AQUÍ ESTÁ TU FLUJO ORIGINAL ---
        showLinkAccountSheet(context, () {
          // Al darle "Añadir", esperar un poco y mostrar Sheet de Verificación
          Future.delayed(const Duration(milliseconds: 300), () {
            showVerificationSheet(context);
          });
        });
      },
      child: Container(
        width: 100, height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
          // Le ponemos un borde sutil para que parezca un botón clickeable
          border: Border.all(color: Colors.white10, width: 1),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.grey, size: 30),
            SizedBox(height: 8),
            Text('Añadir Cuenta', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // Item de Video Seleccionable
  Widget _buildVideoItem(int index) {
    bool isSelected = _selectedVideoIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedVideoIndex = index),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo / Imagen del video
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
                // BORDE BLANCO SI ESTÁ SELECCIONADO
                border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 3
                ),
                image: const DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/300x500'), // Placeholder visual
                  fit: BoxFit.cover,
                )
            ),
          ),

          // Icono Check Blanco arriba a la derecha
          if (isSelected)
            Positioned(
              top: 8, right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 12, color: Colors.black),
              ),
            ),

          // Etiqueta de tiempo (Hace x minutos)
          Positioned(
            bottom: 8, left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
              child: const Row(
                children: [
                  Icon(Icons.access_time, color: Colors.white, size: 10),
                  SizedBox(width: 4),
                  Text('Hace 4 min', style: TextStyle(color: Colors.white, fontSize: 10)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // --- MODAL DISCLAIMER ---
  void _showDisclaimerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const DisclaimerModalContent(),
    );
  }
}

// --- WIDGET INDEPENDIENTE PARA EL MODAL (Para manejar el Checkbox) ---
class DisclaimerModalContent extends StatefulWidget {
  const DisclaimerModalContent({super.key});

  @override
  State<DisclaimerModalContent> createState() => _DisclaimerModalContentState();
}

class _DisclaimerModalContentState extends State<DisclaimerModalContent> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550, // Altura fija para el modal
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text('Disclaimer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),

          // Texto del disclaimer
          const Expanded(
            child: SingleChildScrollView(
              child: Text(
                'Declaro soy el único responsable de gestionar y cobrar de forma manual las ganancias generadas por mi video, así como de revisar y hacer seguimiento al presupuesto y estado de la campaña asociada.\n\nAl enviar mi video, acepto que la plataforma no es responsable de la falta de cobro, errores en los datos de pago ni de la gestión del presupuesto de la campaña; debo verificar periódicamente los importes, fechas y condiciones de pago de mis campañas.',
                style: TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Checkbox interactivo
          GestureDetector(
            onTap: () => setState(() => _isChecked = !_isChecked),
            child: Row(
              children: [
                Container(
                  width: 24, height: 24,
                  decoration: BoxDecoration(
                    color: _isChecked ? Colors.black : Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: _isChecked
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'He leído y declaro responsabilidad por mi cobro',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Botón Aceptar y Enviar
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              // Solo se activa si el checkbox está marcado
              onPressed: _isChecked
                  ? () {
                Navigator.pop(context); // Cierra el modal actual
                // Navega a la pantalla final de éxito
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SuccessSentScreen()));
              }
                  : null,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.black,
                disabledBackgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Aceptar y Enviar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

// --- PANTALLA DE ÉXITO FINAL ---
class SuccessSentScreen extends StatelessWidget {
  const SuccessSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro puro
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // ICONO CHECK (Tu imagen ic_listo.png)
              Image.asset(
                'assets/images/ic_listo.png',
                width: 80,
                height: 80,
                color: Colors.white, // Pintado de blanco para que resalte
              ),

              const SizedBox(height: 30),

              const Text(
                '¡Listo! Muy pronto el equipo revisará tu contenido',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
              ),

              const Spacer(),

              // Botón Entendido (Por ahora sin conexión, como pediste)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    // Acción pendiente ("no lo conectes a nada aun")
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A), // Gris oscuro como en tu imagen
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Entendido', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}