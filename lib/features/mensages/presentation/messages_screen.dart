import 'package:flutter/material.dart';
import 'package:inklop/features/home/presentation/chat_list_screen.dart';
import '../../home/domain/campaign_model.dart'; // Verifica que la ruta sea correcta

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ---------------------------------------------------------------
          // 1. HEADER COMPACTO Y ALINEADO (IGUAL AL EXPLORE)
          // ---------------------------------------------------------------
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black, Color(0xFF370068)], // Mismo gradiente
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            // Padding reducido para compactar
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // ALINEACIÓN A LA IZQUIERDA
              children: [
                const Text(
                  'Mis Chats',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22, // Tamaño consistente
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4), // Espacio pequeño entre título y subtítulo
                const Text(
                  'Conecta con la comunidad',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 15), // Espacio antes del buscador

                // --- BARRA DE BÚSQUEDA COMPACTA ---
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0), // Vertical 0 porque el TextField tiene su propio padding
                  height: 42, // Altura fija compacta
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      hintStyle: TextStyle(color: Color(0xFFADADAD), fontSize: 13, fontWeight: FontWeight.bold),
                      prefixIcon: Icon(Icons.search, color: Color(0xFFADADAD), size: 20),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 8), // Ajuste fino para centrar el texto verticalmente
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ---------------------------------------------------------------
          // 2. LISTA DE CHATS
          // ---------------------------------------------------------------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              physics: const BouncingScrollPhysics(),
              children: [
                // --- CHATS DESDE TU DATA FAKE ---
                ...fakeCampaigns.map((campaign) {
                  return Column(
                    children: [
                      _buildInboxItem(
                        context,
                        title: campaign.title,
                        lastMessage: 'Comunidad: ¡Hola! Recuerden subir...',
                        time: '10:30 AM',
                        imageUrl: campaign.photoUrl,
                        notificationCount: 2,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatListScreen(
                                campaignTitle: campaign.title,
                                campaignImage: campaign.photoUrl,
                              ),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 20, color: Color(0xFFF0F0F0)), // Separador más sutil
                    ],
                  );
                }),

                // --- CHAT DE SOPORTE (Hardcoded) ---
                _buildInboxItem(
                  context,
                  title: 'Soporte Inklop',
                  lastMessage: 'Ticket resuelto.',
                  time: 'Lun',
                  imageUrl: 'https://via.placeholder.com/150/000000/FFFFFF?text=Soporte',
                  notificationCount: 0,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET DE CADA CHAT (ITEM)
  Widget _buildInboxItem(BuildContext context, {
    required String title,
    required String lastMessage,
    required String time,
    required String imageUrl,
    required int notificationCount,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4), // Pequeño padding extra para zona táctil
        child: Row(
          children: [
            // Avatar
            Container(
              width: 50, height: 50, // Avatar un poco más compacto (antes 60)
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.grey[200],
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 20),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Información del Chat
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          lastMessage,
                          style: TextStyle(
                            color: notificationCount > 0 ? Colors.black87 : Colors.grey[600],
                            fontWeight: notificationCount > 0 ? FontWeight.w600 : FontWeight.normal,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (notificationCount > 0)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.all(5), // Badge más pequeño
                          decoration: const BoxDecoration(
                            color: Color(0xFF370068), // Morado principal
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            notificationCount.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
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