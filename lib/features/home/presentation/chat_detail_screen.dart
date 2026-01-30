import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String channelName;

  const ChatDetailScreen({super.key, required this.channelName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. HEADER (Igual que la anterior pero con nombre de sala)
          Container(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2D0052), Color(0xFF15002B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 16),
                CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 18,
                  child: const Icon(Icons.info, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      channelName,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Text(
                      'Inklop',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 2. MENSAJE FIJADO (Pinned)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            color: const Color(0xFFE0E0E0), // Gris claro
            child: Row(
              children: [
                const Icon(Icons.push_pin, size: 16, color: Colors.black54),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Hola a todos los creadores, por favor no olvidar cumplir los requisitos...',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // 3. LISTA DE MENSAJES
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                _MessageBubble(
                  sender: 'ItzTzina',
                  text: 'Holaa 👋🏻',
                  isMe: false,
                  avatarColor: Colors.brown,
                ),
                _MessageBubble(
                  sender: 'ItzTzina',
                  text: 'Hey 👋🏻',
                  isMe: false,
                  avatarColor: Colors.brown,
                ),
                _MessageBubble(
                  sender: 'ClipsPeru',
                  text: 'Hola a todoss, que emocion esta app. Ya mandé mi primer video, esperemos a monetizar pronto',
                  isMe: false,
                  avatarColor: Colors.redAccent,
                ),
                _MessageBubble(
                  sender: 'Vadu',
                  text: 'Chicosss alguien me ayuda? no se como clipear',
                  isMe: false,
                  avatarColor: Colors.blueAccent,
                ),
                // MI MENSAJE
                _MessageBubble(
                  sender: '', // No muestra nombre si soy yo
                  text: 'Es facil, pero aqui no es de clips, es contenido ugc',
                  isMe: true,
                  avatarColor: Colors.transparent,
                ),
                _MessageBubble(
                  sender: 'Vadu',
                  text: 'okok pero alguien me enseña?',
                  isMe: false,
                  avatarColor: Colors.blueAccent,
                ),
                _MessageBubble(
                  sender: 'marcovial10',
                  text: 'Siii normal, tienes que sacarle clips a los streamers en kick, luego descargarlo con sstil.io y subirlo a tiktok',
                  isMe: false,
                  avatarColor: Colors.green,
                ),
              ],
            ),
          ),

          // 4. INPUT DE TEXTO
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  const Icon(Icons.add_circle, color: Colors.black87),
                  const SizedBox(width: 12),
                  const Icon(Icons.image, color: Colors.black87),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Center(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Escribe un mensaje',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 4), // Ajuste fino
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.mic, color: Colors.black87),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// COMPONENTE DE BURBUJA DE MENSAJE
class _MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  final Color avatarColor;

  const _MessageBubble({
    required this.sender,
    required this.text,
    required this.isMe,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: avatarColor,
              child: const Icon(Icons.person, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(sender, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? const Color(0xFF1A1A1A) : const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
                      bottomRight: isMe ? Radius.zero : const Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 14,
              backgroundColor: Colors.green, // Mi avatar
              child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
          ]
        ],
      ),
    );
  }
}