import 'package:flutter/material.dart';
import 'package:inklop/features/home/presentation/Video_Analytics_Screen.dart';
import 'my_campaigns_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Todos', 'Aceptados', 'Pendientes', 'Denegados'];

  @override
  Widget build(BuildContext context) {
    // ==========================================
    // VARIABLES DE DIMENSIÓN
    // ==========================================

    // 1. Altura del fondo morado
    final double headerHeight = 100.0;

    // 2. Dónde empiezan las 3 tarjetas (Top Offset)
    final double cardTopOffset = 100.0;

    // 3. Altura de las tarjetas de métricas
    final double cardsHeight = 95.0;

    // 4. ALTURA TOTAL DEL BLOQUE FIJO
    // Sumamos offset + altura de cards + un margen extra (20) para la sombra inferior.
    // Esto define el tamaño exacto del área que NO se va a mover.
    final double totalFixedHeaderHeight = cardTopOffset + cardsHeight + 20;

    return Scaffold(
      backgroundColor: Colors.white,
      // Usamos Column para separar físicamente lo estático de lo scrollable
      body: Column(
        children: [
          // ==================================================
          // 1. SECCIÓN ESTÁTICA (HEADER + TARJETAS)
          // ==================================================
          // Este SizedBox define el "techo" que nunca se moverá.
          SizedBox(
            height: totalFixedHeaderHeight,
            child: Stack(
              clipBehavior: Clip.none, // Permite que las sombras se vean bien
              children: [
                // A. FONDO MORADO
                Positioned(
                  top: 0, left: 0, right: 0,
                  height: headerHeight,
                  child: Container(
                    padding: const EdgeInsets.only(top: 55, left: 24, right: 24),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2D0052), Color(0xFF15002B)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tus Métricas',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // B. TARJETAS FLOTANTES (3 CARDS)
                Positioned(
                  top: cardTopOffset,
                  left: 20,
                  right: 20,
                  height: cardsHeight,
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: MetricCard(
                          label: 'Vistas\nTotales',
                          value: '40.2K',
                          iconPath: 'assets/images/ic_views.png'
                      )),
                      SizedBox(width: 10),
                      Expanded(child: MetricCard(
                          label: 'Videos\nAceptados',
                          value: '10',
                          iconPath: 'assets/images/ic_video_check.png'
                      )),
                      SizedBox(width: 10),
                      Expanded(child: MetricCard(
                          label: 'Engagement\nPromedio',
                          value: '1.3%',
                          iconPath: 'assets/images/ic_engagement.png'
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ==================================================
          // 2. SECCIÓN SCROLLABLE (CAMPAÑAS Y VIDEOS)
          // ==================================================
          // Expanded hace que esta parte ocupe todo el espacio restante.
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 10, bottom: 20), // Padding normal
              children: [

                // --- ZONA DE CAMPAÑAS Y FILTROS ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Campañas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Campañas Activas', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const MyCampaignsScreen()));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(20)),
                              child: const Text('Ver todas', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Tarjeta de Campaña
                      const ActiveCampaignCard(),

                      const SizedBox(height: 20),

                      // Header Mi Contenido
                      const Text('Mi Contenido', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),

                      // Filtros (Barra negra)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          children: List.generate(_filters.length, (index) {
                            return Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedFilterIndex = index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: _selectedFilterIndex == index ? Colors.white : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    _filters[index],
                                    style: TextStyle(
                                      color: _selectedFilterIndex == index ? Colors.black : Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // --- GRID DE VIDEOS ---
                // Nota: Usamos shrinkWrap y NeverScrollableScrollPhysics
                // para que scrollee junto con el ListView padre.
                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return _buildContentGridItem(index);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET DE ITEM DEL GRID (IGUAL QUE ANTES) ---
  Widget _buildContentGridItem(int index) {
    String status = index % 3 == 0 ? 'Aceptado' : (index % 2 == 0 ? 'Pendiente' : 'Denegado');
    Color statusColor = status == 'Aceptado' ? const Color(0xFF5DD669) : (status == 'Pendiente' ? Colors.orange : Colors.red);
    String price = index % 2 == 0 ? 'S/40.00' : 'S/100.00';

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoAnalyticsScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFF3F3F3),
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: NetworkImage('https://via.placeholder.com/200x300'),
              fit: BoxFit.cover,
            )
        ),
        child: Stack(
          children: [
            Positioned(
              top: 6, right: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(4)),
                child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
              ),
            ),
            Positioned(
              top: 6, left: 6,
              child: Row(
                children: [
                  const Icon(Icons.remove_red_eye, color: Colors.white, size: 9),
                  const SizedBox(width: 4),
                  Text('${(index + 1) * 215}', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Positioned(
              bottom: 8, left: 0, right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Text(price, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// WIDGETS AUXILIARES (IGUAL QUE ANTES)
// ==========================================

class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final String iconPath;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 15, offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 20,
            height: 20,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.show_chart, size: 20, color: Color(0xFF2D0052)),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54, fontSize: 9, height: 1.1),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class ActiveCampaignCard extends StatelessWidget {
  const ActiveCampaignCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 45, height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            padding: const EdgeInsets.all(6),
            child: const Icon(Icons.local_offer, color: Colors.orange),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Navidad con Topitop', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const Text('@topitop.pe', style: TextStyle(color: Colors.grey, fontSize: 11)),
                const SizedBox(height: 6),
                Row(children: [_buildTag('Recomendación'), const SizedBox(width: 6), _buildTag('Tech')]),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(20)),
                child: const Text('S/20/1K', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: const TextStyle(fontSize: 8, color: Colors.grey)),
    );
  }
}