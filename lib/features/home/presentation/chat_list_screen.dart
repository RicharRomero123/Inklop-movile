import 'package:flutter/material.dart';
import 'chat_detail_screen.dart'; // Importamos el detalle del chat

class ChatListScreen extends StatelessWidget {
  final String campaignTitle;

  const ChatListScreen({super.key, required this.campaignTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. HEADER MORADO
          Container(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2D0052), Color(0xFF15002B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 16),
                // Logo de la marca (simulado)
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Image.asset('assets/images/logo_small.png', scale: 2), // O un Icono
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaignTitle,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Text(
                        'Comunidad',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. LISTA DE CHATS
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildChatItem(
                  context,
                  title: 'Anuncios',
                  subtitle: '@rokys.pe: Hola a todos, por favor seguir...',
                  time: '11:36 hrs',
                  icon: Icons.campaign_outlined,
                  iconBg: const Color(0xFFE8F5E9),
                  iconColor: Colors.green,
                ),
                const SizedBox(height: 16),
                _buildChatItem(
                  context,
                  title: 'Comunidad Creadores',
                  subtitle: '@cesar.mesia: Chicos ya conseguí mi prime...',
                  time: '11:36 hrs',
                  icon: Icons.forum_outlined, // Icono parecido a la imagen
                  iconBg: Colors.white,
                  iconColor: Colors.orange,
                  isImage: true, // Para simular el logo de Rokys
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, {
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    bool isImage = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatDetailScreen(channelName: title),
          ),
        );
      },
      child: Container(
        color: Colors.transparent, // Para hacer click en toda el área
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar / Icono
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(16),
                border: isImage ? Border.all(color: Colors.grey.shade200) : null,
              ),
              child: isImage
                  ? const Icon(Icons.people_alt, color: Colors.orange) // Aquí iría una imagen real
                  : Icon(icon, color: Colors.black87),
            ),
            const SizedBox(width: 16),

            // Textos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14, height: 1.3),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}