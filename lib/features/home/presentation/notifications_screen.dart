import 'package:flutter/material.dart';
import 'package:inklop/features/home/domain/notification_model.dart';
import 'widgets/notification_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), // Fondo Oscuro (Casi negro)
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        centerTitle: false, // Alineado a la izquierda según iOS/Diseño
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero, // Para centrar bien el icono
          ),
        ),
        title: const Text(
          'Mis Notificaciones',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: fakeNotifications.length,
        itemBuilder: (context, index) {
          return NotificationItem(notification: fakeNotifications[index]);
        },
      ),
    );
  }
}