import 'package:flutter/material.dart';
import '../../domain/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white24, width: 0.5), // Línea divisoria sutil
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Icono Circular
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: notification.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(notification.icon, color: notification.iconColor, size: 24),
          ),
          const SizedBox(width: 16),

          // 2. Textos
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.body,
                  style: const TextStyle(
                    color: Colors.white70, // Blanco un poco transparente para el cuerpo
                    fontSize: 12,
                    height: 1.4, // Altura de línea para mejor lectura
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}