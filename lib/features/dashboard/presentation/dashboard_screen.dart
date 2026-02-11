import 'package:flutter/material.dart';

// --- TUS IMPORTACIONES ---
import 'my_campaigns_screen.dart';
import 'package:inklop/features/home/presentation/Video_Analytics_Screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------------------------------------
          // ZONA ESTÁTICA
          // ---------------------------------------------

          // 1. HEADER (Con Gradiente Morado a Negro)
          const HeaderSection(),

          // 2. MÉTRICAS y CAMPAÑAS
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 15, 16, 5),
            child: Column(
              children: [
                // Fila de Métricas con iconos PNG y texto BOLD
                const MetricsRow(),

                const SizedBox(height: 15),

                // Título Campañas y Botón "Ver todas"
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Campañas Activas",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),

                    // NAVEGACIÓN A CAMPAÑAS
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyCampaignsScreen()),
                        );
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Ver todas",
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const CampaignCard(),
              ],
            ),
          ),

          // ---------------------------------------------
          // ZONA SCROLLEABLE
          // ---------------------------------------------
          Expanded(
            child: Container(
              width: double.infinity,
              color: const Color(0xFFF8F9FA),
              child: ListView(
                // Padding ajustado
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 20),
                children: [
                  const Text(
                    "Mi Contenido",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Tabs (Filtros)
                  const CustomTabBar(),

                  // --- ESPACIO REDUCIDO AQUÍ (Entre filtros y videos) ---
                  const SizedBox(height: 8),

                  // GRID DE VIDEOS
                  const ContentGrid(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// WIDGETS AUXILIARES
// -----------------------------------------------------------------------------

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 25),
      decoration: const BoxDecoration(
        // --- CAMBIO AQUÍ: USO DE GRADIENTE ---
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2A0D45), // Morado oscuro original
            Colors.black,      // Negro
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tus Métricas",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class MetricsRow extends StatelessWidget {
  const MetricsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        // Usamos los paths de tus assets aquí
        MetricCard(
            iconPath: "assets/images/ic_views.png",
            label: "Vistas\nTotales",
            value: "40.2K"
        ),
        MetricCard(
            iconPath: "assets/images/ic_video_check.png",
            label: "Videos\nAceptados",
            value: "10"
        ),
        MetricCard(
            iconPath: "assets/images/ic_engagement.png",
            label: "Engagement\nPromedio",
            value: "1.3%"
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final String value;

  const MetricCard({
    super.key,
    required this.iconPath,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = (MediaQuery.of(context).size.width - 48) / 3;

    return Container(
      width: cardWidth,
      // AUMENTADO: Padding vertical para hacer las cards más grandes
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Imagen del asset
          Image.asset(
            iconPath,
            width: 28, // Tamaño del icono ajustado
            height: 28,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Colors.black54, height: 1.2),
          ),
          const SizedBox(height: 6),
          // AUMENTADO: Texto más grande y Extra Bold
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class CampaignCard extends StatelessWidget {
  const CampaignCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Text("t", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Navidad con Topitop", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const Text("@topitop.pe", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _buildTag("Recomendación"),
                    const SizedBox(width: 5),
                    _buildTag("Tech"),
                    const SizedBox(width: 5),
                    const Icon(Icons.tiktok, size: 14, color: Colors.black),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF333333), borderRadius: BorderRadius.circular(8)),
                child: const Text("s/20/1K", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
      child: Text(text, style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.w500)),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          _buildTab("Todos", true),
          _buildTab("Aceptados", false),
          _buildTab("Pendientes", false),
          _buildTab("Denegados", false),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}

class ContentGrid extends StatelessWidget {
  const ContentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.55,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return _buildVideoCard(context, index);
      },
    );
  }

  Widget _buildVideoCard(BuildContext context, int index) {
    // NAVEGACIÓN A VIDEO ANALYTICS
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VideoAnalyticsScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          image: const DecorationImage(
            image: NetworkImage("https://picsum.photos/300/500"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black26, Colors.transparent, Colors.black45],
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(color: const Color(0xFF4ADE80), borderRadius: BorderRadius.circular(6)),
                child: const Text("Aceptado", style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
              ),
            ),
            Positioned(
              top: 5,
              left: 5,
              child: Row(
                children: const [
                  Icon(Icons.remove_red_eye, color: Colors.white, size: 8),
                  SizedBox(width: 2),
                  Text("2.1K", style: TextStyle(color: Colors.white, fontSize: 8)),
                ],
              ),
            ),
            Positioned(
              bottom: 6,
              left: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 3),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: const Text("s/40.00 🔒", style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}