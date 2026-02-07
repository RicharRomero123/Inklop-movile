import 'package:flutter/material.dart';
import 'package:inklop/features/home/domain/campaign_model.dart';
import 'package:inklop/features/home/presentation/notifications_screen.dart';
import 'package:inklop/features/home/presentation/widgets/campaign_card.dart';
import 'search_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ---------------------------------------------------------------
          // ZONA ESTÁTICA SIN PADDING LATERAL (Ocupa todo el ancho)
          // ---------------------------------------------------------------
          Container(
            width: double.infinity, // Asegura que ocupe todo el ancho
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black, Color(0xFF370068)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            // Padding interno solo para separar el contenido del borde,
            // pero el contenedor llega al límite de la pantalla
            padding: const EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Explora Oportunidades',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.8,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const NotificationsScreen(),
                            transitionsBuilder: (_, animation, __, child) {
                              return SlideTransition(
                                position: animation.drive(Tween(begin: const Offset(0.0, -1.0), end: Offset.zero)),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/ic_notification_home.png',
                        height: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // BUSCADOR FIJO AL BORDE
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/ic_search_explore.png', height: 22, color: const Color(0xFFADADAD)),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Busca una campaña, marca o creador',
                            style: TextStyle(color: Color(0xFFADADAD), fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // FILTROS TAMBIÉN AL BORDE
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Campañas Disponibles',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
                  ),
                ),
                const SizedBox(height: 16),
                // Scroll de filtros que empieza pegado al borde
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildFilterIconChip(),
                      _buildFilterChip('Todos', false),
                      _buildFilterChip('Guardados', false),
                      _buildFilterChip('Más Populares', true),
                      _buildFilterChip('Más Pagados', false),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ---------------------------------------------------------------
          // ZONA CON SCROLL
          // ---------------------------------------------------------------
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: fakeCampaigns.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return CampaignCard(campaign: fakeCampaigns[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterIconChip() {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Image.asset('assets/images/ic_filter_settings.png', height: 20, color: const Color(0xFF707070)),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1D1D1D) : const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: isSelected ? Colors.transparent : const Color(0xFFF0F0F0)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFFADADAD),
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}