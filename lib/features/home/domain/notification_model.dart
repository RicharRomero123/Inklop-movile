import 'package:flutter/material.dart';

class NotificationModel {
  final String title;
  final String body;
  final IconData icon; // Usaremos iconos nativos por ahora
  final Color iconColor;
  final Color backgroundColor;

  NotificationModel({
    required this.title,
    required this.body,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });
}

// --- DATA FAKE (Basada en tu imagen) ---
final List<NotificationModel> fakeNotifications = [
  NotificationModel(
    title: 'Creadores Inklop',
    body: 'Inklop ha lanzado su nueva campaña! Empieza ahora!',
    icon: Icons.info_outline,
    iconColor: Colors.white,
    backgroundColor: const Color(0xFFFF8A65), // Naranja suave
  ),
  NotificationModel(
    title: 'Campaña Navideña Interbank',
    body: 'La campaña está a punto de finalizar. Solo faltan 2 días, crea contenido lo más pronto que puedas.',
    icon: Icons.bookmark_border,
    iconColor: Colors.white,
    backgroundColor: const Color(0xFF00C853), // Verde
  ),
  NotificationModel(
    title: 'Campaña Navideña DBS',
    body: 'DBS acaba de lanzar su campaña. Aprovecha y empieza a crear contenido',
    icon: Icons.bookmark_border,
    iconColor: Colors.white,
    backgroundColor: const Color(0xFF00C853), // Verde
  ),
];