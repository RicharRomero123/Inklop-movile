import 'package:flutter/material.dart';
import '../../home/presentation/chat_list_screen.dart';
import '../domain/dashboard_models.dart';
import 'widgets/dashboard_widgets.dart';
import 'my_campaigns_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Todos', 'Aceptados', 'Pendientes', 'Denegados'];

  // Altura fija del Header Morado
  final double _headerHeight = 280.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Stack(
        children: [
          // 1. CAPA DE FONDO: CONTENIDO DESLIZABLE
          // (Se mueve y pasa por detrás del header)
          SingleChildScrollView(
            // Le damos un padding arriba igual a la altura del header
            // para que el primer elemento empiece donde termina lo morado
            padding: EdgeInsets.only(top: _headerHeight - 20, left: 24, right: 24, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30), // Espacio extra para soltura visual

                // SECCIÓN: CAMPAÑAS ACTIVAS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Campañas Activas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyCampaignsScreen())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
                        child: const Text('Ver todas', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const CompactCampaignCard(),

                const SizedBox(height: 30),

                // SECCIÓN: MI CONTENIDO
                // Aquí usamos StickyHeader manual si quisieras, pero por ahora es flujo normal
                const Text('Mi Contenido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                // Filtros (Tabs)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_filters.length, (index) {
                      return ContentFilterTab(
                        label: _filters[index],
                        isSelected: _selectedFilterIndex == index,
                        onTap: () => setState(() => _selectedFilterIndex = index),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),

                // Lista de Videos
                ...fakeContents.map((content) => ContentItemCard(content: content)),
              ],
            ),
          ),

          // 2. CAPA SUPERIOR: HEADER MORADO FIJO
          // (Nunca se mueve)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: _headerHeight,
            child: Container(
              padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2D0052), Color(0xFF15002B)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
                  ]
              ),
              child: Column(
                children: [
                  // Título e Icono
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tus Métricas',
                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatListScreen(campaignTitle: "Mis Chats")));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Cards de Métricas
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: MetricCard(label: 'Vistas\nTotales', value: '40.2K', icon: Icons.visibility_outlined)),
                      SizedBox(width: 12),
                      Expanded(child: MetricCard(label: 'Videos\nAceptados', value: '10', icon: Icons.play_circle_outline)),
                      SizedBox(width: 12),
                      Expanded(child: MetricCard(label: 'Engagement\nPromedio', value: '1.3%', icon: Icons.insert_chart_outlined)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}