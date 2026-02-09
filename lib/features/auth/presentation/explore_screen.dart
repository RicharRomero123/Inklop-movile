import 'package:flutter/material.dart';
import 'package:inklop/features/home/domain/campaign_model.dart';
import 'package:inklop/features/home/presentation/notifications_screen.dart';
import 'package:inklop/features/home/presentation/widgets/campaign_card.dart';
import 'search_screen.dart'; // Asegúrate de que la ruta sea correcta

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Todos', 'Guardados', 'Más Populares', 'Más Pagados'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ---------------------------------------------------------------
          // ZONA ESTÁTICA COMPACTA (HEADER)
          // ---------------------------------------------------------------
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black, Color(0xFF370068)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30), // Reduje el radio un poco
                bottomRight: Radius.circular(30),
              ),
            ),
            // REDUCCIÓN 1: Menos padding arriba y abajo
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 20),
            child: Column(
              children: [
                // Fila Superior
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Explora Oportunidades',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22, // REDUCCIÓN 2: De 26 a 22
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
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
                        height: 24, // REDUCCIÓN 3: Icono un poco más chico
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15), // REDUCCIÓN 4: Menos espacio entre título y buscador

                // -----------------------------------------------------------
                // BUSCADOR COMPACTO
                // -----------------------------------------------------------
                GestureDetector(
                  onTap: () {
                    // ... Tu lógica de navegación intacta ...
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 400),
                        pageBuilder: (_, __, ___) => const SearchScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          return SlideTransition(position: animation.drive(tween), child: child);
                        },
                      ),
                    );
                  },
                  child: Container(
                    // REDUCCIÓN 5: Padding vertical reducido a 10 (antes 16) para hacerlo más "flaco"
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20), // Radio un poco más ajustado
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/ic_search_explore.png', height: 18, color: const Color(0xFFADADAD)), // Icono más chico
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Busca una campaña...', // Texto más corto opcional
                            style: TextStyle(color: Color(0xFFADADAD), fontSize: 13, fontWeight: FontWeight.bold), // Fuente más chica
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ---------------------------------------------------------------
          // ZONA DE FILTROS COMPACTA
          // ---------------------------------------------------------------
          Padding(
            // REDUCCIÓN 6: Menos espacio arriba y abajo de la zona de filtros
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Campañas Disponibles',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)), // Fuente reducida de 22 a 18
                  ),
                ),
                const SizedBox(height: 10), // Menos espacio antes de los chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildFilterIconChip(),
                      ...List.generate(_filters.length, (index) {
                        return _buildFilterChip(_filters[index], index);
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ---------------------------------------------------------------
          // LISTA DE CAMPAÑAS (AHORA TIENE MÁS ESPACIO)
          // ---------------------------------------------------------------
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5), // Menos padding vertical inicial
              itemCount: fakeCampaigns.length, // Asegúrate de tener tu lista fakeCampaigns importada o definida
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

  // Chip de Icono (Ajustes) - Compacto
  Widget _buildFilterIconChip() {
    return Container(
      margin: const EdgeInsets.only(right: 8), // Margen reducido
      padding: const EdgeInsets.all(10), // Padding reducido (antes 12)
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Image.asset('assets/images/ic_filter_settings.png', height: 18, color: const Color(0xFF707070)), // Icono más chico
    );
  }

  // Chip de Texto (Seleccionable) - Compacto
  Widget _buildFilterChip(String label, int index) {
    final isSelected = _selectedFilterIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilterIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8), // Margen entre chips reducido
        // REDUCCIÓN 7: Padding interno del chip mucho más pequeño
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D1D1D) : const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : const Color(0xFFF0F0F0)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFFADADAD),
            fontSize: 13, // Fuente reducida (antes 15)
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}