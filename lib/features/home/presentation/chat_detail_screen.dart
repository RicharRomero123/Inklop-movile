import 'package:flutter/material.dart';

class ChatDetailScreen extends StatelessWidget {
  final String channelName;

  const ChatDetailScreen({super.key, required this.channelName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Usamos Column para estructurar Header, Lista y Input
      body: Column(
        children: [
          // ---------------------------------------------
          // 1. HEADER CORREGIDO (Degradado completo)
          // ---------------------------------------------
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10, // Padding dinámico para status bar
                left: 16,
                right: 16,
                bottom: 20
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              // El degradado exacto de tus otras pantallas
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2A0D45), // Morado oscuro
                  Colors.black,      // Negro
                ],
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
                const SizedBox(width: 12),
                // Avatar de la comunidad
                const CircleAvatar(
                  backgroundColor: Color(0xFFFF6B6B), // Color rojizo/salmón de la imagen
                  radius: 20,
                  child: Icon(Icons.info_outline, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      channelName, // "Comunidad Creadores"
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                    const Text(
                      'Inklop',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ---------------------------------------------
          // 2. MENSAJE FIJADO (Pinned)
          // ---------------------------------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Gris muy suave
            ),
            child: Row(
              children: [
                const Icon(Icons.push_pin, size: 18, color: Colors.black54),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Hola a todos los creadores, por favor no olvidar cumplir los requisitos...',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // ---------------------------------------------
          // 3. LISTA DE MENSAJES
          // ---------------------------------------------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
                // MI MENSAJE (Negro con texto blanco)
                _MessageBubble(
                  sender: '',
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
                  text: 'Siii normal, tienes que sacarle clips a los stramers en kick, luego descargarlo con sstil.io y subirlo a tiktok',
                  isMe: false,
                  avatarColor: Colors.green,
                ),
              ],
            ),
          ),

          // ---------------------------------------------
          // 4. INPUT DE TEXTO (REDUCIDO Y ESTILIZADO)
          // ---------------------------------------------
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              // Línea superior sutil si lo deseas
              border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
            ),
            child: SafeArea(
              top: false, // Solo safe area abajo para iPhone X+
              child: Row(
                children: [
                  // Ícono Más (+) Círculo relleno negro
                  const Icon(Icons.add_circle, color: Color(0xFF1E1E1E), size: 26),
                  const SizedBox(width: 12),

                  // Ícono Imagen (Cuadrado con montañas)
                  const Icon(Icons.image_outlined, color: Color(0xFF1E1E1E), size: 26),
                  const SizedBox(width: 12),

                  // Campo de Texto (Capsula)
                  Expanded(
                    child: Container(
                      height: 40, // Altura reducida (menos "ancho")
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: 'Escribe un mensaje',
                          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                          border: InputBorder.none,
                          isDense: true, // Importante para reducir altura interna
                          contentPadding: EdgeInsets.zero, // Quitamos padding por defecto
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Micrófono
                  const Icon(Icons.mic_none_outlined, color: Colors.black87, size: 26),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------
// WIDGET AUXILIAR: BURBUJA DE MENSAJE
// ---------------------------------------------
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
          // Avatar (Solo si no soy yo)
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: avatarColor,
              child: const Icon(Icons.person, size: 18, color: Colors.white),
            ),
            const SizedBox(width: 8),
          ],

          // Burbuja de texto
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isMe)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 4),
                    child: Text(sender, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    // Color Negro para mí, Gris claro para otros
                    color: isMe ? const Color(0xFF1E1E1E) : const Color(0xFFF2F2F7),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: isMe ? const Radius.circular(18) : Radius.zero,
                      bottomRight: isMe ? Radius.zero : const Radius.circular(18),
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

          // Avatar (Si soy yo - Derecha)
          if (isMe) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF1E1E1E), // O tu foto de perfil
              child: Icon(Icons.person, size: 18, color: Colors.white),
            ),
          ]
        ],
      ),
    );
  }
}