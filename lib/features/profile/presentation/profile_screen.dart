import 'package:flutter/material.dart';
import 'widgets/profile_widgets.dart';
import 'screens/settings_screen.dart'; // Importaremos esto luego
import 'screens/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. HEADER (Avatar + Stats + Edit)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: NetworkImage('https://i.pravatar.cc/300'), // Placeholder
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Stats y Botón
                  Expanded(
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ProfileStatItem(value: '12', label: 'Campañas'),
                            ProfileStatItem(value: '15k', label: 'Visualizaciones'),
                            ProfileStatItem(value: 's/1.5k', label: 'Ganancias'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1A1A1A),
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                  minimumSize: const Size(0, 32),
                                ),
                                child: const Text('Editar Perfil', style: TextStyle(color: Colors.white, fontSize: 12)),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Botón Configuración (Engranaje)
                            Container(
                              width: 32, height: 32,
                              decoration: const BoxDecoration(color: Color(0xFFF0F0F0), shape: BoxShape.circle),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.settings, size: 18, color: Colors.black),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // 2. INFO DEL USUARIO
              const Text('Cesar Mesia', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const Text('@cesar.mesia', style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 12),
              const Text(
                'Creador de contenido apasionado por el gaming.\nFundador de Inklop para cambiar el mundo',
                style: TextStyle(fontSize: 14, height: 1.4),
              ),
              const SizedBox(height: 16),

              // Ubicación y Fecha
              Row(
                children: [
                  Icon(Icons.public, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text('Lima, Perú', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(width: 16),
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Text('Se unió el 21 Nov', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),

              const SizedBox(height: 30),

              // 3. CUENTAS VINCULADAS (Iconos)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SocialAccountButton(icon: Icons.tiktok, label: '@inklop.journey', onTap: () {}),
                  const SizedBox(width: 20),
                  SocialAccountButton(icon: Icons.tiktok, label: '@inklop.pe', onTap: () {}),
                  const SizedBox(width: 20),
                  SocialAccountButton(label: 'Agregar cuenta', isAdd: true, onTap: () {
                    // Aquí podrías navegar a LinkedAccountsScreen
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}