import 'package:flutter/material.dart';
import 'package:inklop/features/home/domain/campaign_model.dart';
import 'widgets/campaign_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Fondo gris muy claro
      body: Column(
        children: [
          // 1. HEADER MORADO CURVO
          Container(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 30),
            decoration: const BoxDecoration(
              color: Color(0xFF2D0052), // Tu color morado oscuro
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
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Buscador (Search Component)
                Container(
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
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Busca una campaña, marca o creador',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. CUERPO SCROLLABLE (Filtros y Lista)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              children: [
                const Text(
                  'Campañas Disponibles',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Filtros Horizontales
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Todos', false), // Icono de filtros
                      _buildFilterChip('Todos', false, isText: true),
                      _buildFilterChip('Guardados', false, isText: true),
                      _buildFilterChip('Más Populares', true, isText: true), // Seleccionado
                      _buildFilterChip('Más Pagados', false, isText: true),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Lista de Campañas (Data Fake)
                ...fakeCampaigns.map((campaign) => CampaignCard(campaign: campaign)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget pequeño para los chips de filtro
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
              fontWeight: FontWeight.w500
          )
      )
          : Icon(Icons.tune, size: 18, color: Colors.grey.shade700),
    );
  }
}