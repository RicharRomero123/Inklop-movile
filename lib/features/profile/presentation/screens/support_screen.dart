import 'package:flutter/material.dart';
import '../widgets/profile_widgets.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D0052),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Soporte', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Medios de Contacto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            SupportCard(
                icon: Icons.email_outlined,
                title: 'Email de Soporte',
                subtitle: 'Respuesta en 24 horas',
                detail: 'soporte@inklop.com'
            ),
            SupportCard(
                icon: Icons.phone_in_talk_outlined,
                title: 'Soporte Telefónico',
                subtitle: 'Lunes a Viernes 9am - 6pm',
                detail: '+51 927 555 467'
            ),
            SupportCard(
                icon: Icons.chat_bubble_outline,
                title: 'WhatsApp',
                subtitle: 'Respuesta Inmediata',
                detail: '+51 927 555 467'
            ),
          ],
        ),
      ),
    );
  }
}