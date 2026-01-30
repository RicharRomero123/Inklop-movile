import 'package:flutter/material.dart';
import 'package:inklop/features/home/domain/campaign_model.dart';
import 'package:inklop/features/home/presentation/notifications_screen.dart';
import 'package:inklop/features/home/presentation/widgets/campaign_card.dart';

// Asegúrate de tener este import
import 'search_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          // 1. HEADER MORADO CURVO
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
            decoration: const BoxDecoration(
              color: Color(0xFF2D0052),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                // Título y Notificación
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Explora Oportunidades',
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none, color: Colors.white),
                      onPressed: () {
                        // Animación DE ARRIBA HACIA ABAJO (Notificaciones)
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(milliseconds: 400),
                            reverseTransitionDuration: const Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) => const NotificationsScreen(),
                            transitionsBuilder: (_, animation, __, child) {
                              const begin = Offset(0.0, -1.0); // Desde Arriba
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              return SlideTransition(position: animation.drive(tween), child: child);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // --- BUSCADOR (CON ANIMACIÓN DESDE ABAJO) ---
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        // Duración de la subida
                        transitionDuration: const Duration(milliseconds: 300),
                        reverseTransitionDuration: const Duration(milliseconds: 300),

                        pageBuilder: (_, __, ___) => const SearchScreen(),

                        transitionsBuilder: (_, animation, __, child) {
                          // AQUÍ ESTÁ EL CAMBIO:
                          // Offset(0.0, 1.0) = Empieza ABAJO (fuera de pantalla)
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Busca una campaña, marca o creador',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // ---------------------------------------------
              ],
            ),
          ),

          // 2. CUERPO SCROLLABLE
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              children: [
                const Text(
                  'Campañas Disponibles',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Todos', false),
                      _buildFilterChip('Todos', false, isText: true),
                      _buildFilterChip('Guardados', false, isText: true),
                      _buildFilterChip('Más Populares', true, isText: true),
                      _buildFilterChip('Más Pagados', false, isText: true),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                ...fakeCampaigns.map((campaign) => CampaignCard(campaign: campaign)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, {bool isText = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.shade700 : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isText
          ? Text(
        label,
        style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w500),
      )
          : Icon(Icons.tune, size: 18, color: Colors.grey.shade700),
    );
  }
}