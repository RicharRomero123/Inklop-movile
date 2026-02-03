import 'package:flutter/material.dart';
import '../widgets/profile_widgets.dart';
import 'linked_accounts_screen.dart';
import 'security_screen.dart';
import 'support_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
        title: const Text('Configuración', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Cuenta'),
            SettingsTile(
                icon: Icons.lock_outline,
                title: 'Seguridad',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SecurityScreen()))
            ),
            const Divider(),
            SettingsTile(
                icon: Icons.link,
                title: 'Cuentas Vinculadas',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LinkedAccountsScreen()))
            ),

            const SizedBox(height: 30),
            _buildSectionTitle('Notificaciones'),
            const SettingsTile(
                icon: Icons.notifications_none,
                title: 'Activar Notificaciones',
                trailing: Switch(value: false, onChanged: null) // Switch inactivo visualmente
            ),
            const Divider(),
            const SettingsTile(
                icon: Icons.email_outlined,
                title: 'Activar Notificaciones por e-mail',
                trailing: Switch(value: true, onChanged: null, activeColor: Colors.black)
            ),

            const SizedBox(height: 30),
            _buildSectionTitle('Otros'),
            SettingsTile(
              icon: Icons.build_outlined,
              title: 'Ayuda y soporte',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen())),
            ),
            const Divider(),
            SettingsTile(
              icon: Icons.logout,
              title: 'Cerrar Sesión',
              onTap: () {
                // Lógica de logout
              },
              trailing: const SizedBox(), // Sin flecha
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}