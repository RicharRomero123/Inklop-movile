import 'package:flutter/material.dart';
import 'dart:ui'; // Para el Blur

// Asegúrate de que la ruta sea correcta según tu proyecto
import 'package:inklop/features/home/presentation/Video_Analytics_Screen.dart';
import '../../home/domain/campaign_model.dart';

class MySubmissionsScreen extends StatefulWidget {
  final CampaignModel campaign;

  const MySubmissionsScreen({super.key, required this.campaign});

  @override
  State<MySubmissionsScreen> createState() => _MySubmissionsScreenState();
}

class _MySubmissionsScreenState extends State<MySubmissionsScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['Todos', 'Aceptados', 'Pendientes', 'Denegados'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. CABECERA PERSONALIZADA
          _buildCustomHeader(),

          // 2. CONTENIDO PRINCIPAL
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Mis envíos',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Gestiona el contenido enviado en esta campaña',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),

                  const SizedBox(height: 24),

                  // FILTROS (Barra Negra)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151515), // Fondo NEGRO
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_filters.length, (index) {
                        return Expanded(child: _buildSegmentedFilter(index));
                      }),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // GRID DE VIDEOS
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.only(bottom: 30),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 12, // Aumenté a 12 para ver más variedad
                      itemBuilder: (context, index) {
                        return _buildVideoCard(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS ---

  Widget _buildSegmentedFilter(int index) {
    bool isSelected = _selectedFilterIndex == index;

    return GestureDetector(
      // CORRECCIÓN: Aquí solo cambiamos el estado del filtro, NO navegamos.
      onTap: () {
        setState(() {
          _selectedFilterIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          _filters[index],
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12, // Ajusté un poco para que entren bien
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildCustomHeader() {
    final double paddingTop = MediaQuery.of(context).padding.top;
    const double headerHeight = 140;

    return SizedBox(
      height: headerHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Image.network(
                    widget.campaign.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(color: Colors.black.withOpacity(0.4)),
              ],
            ),
          ),

          Positioned(
            top: paddingTop + 10,
            left: 10,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 45, height: 45,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(widget.campaign.photoUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.campaign.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Mis Envíos',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- TARJETA DE VIDEO (Aquí está la navegación) ---
  Widget _buildVideoCard(int index) {
    // Lógica para variar los estados según el índice (Mock Data)
    String status;
    Color statusColor;
    String price = (index % 2 == 0) ? 'S/40.00' : 'S/100.00';

    // Distribuimos los estados: 0=Aceptado, 1=Pendiente, 2=Denegado, repite...
    int remainder = index % 3;
    if (remainder == 0) {
      status = 'Aceptado';
      statusColor = const Color(0xFF5DD669); // Verde
    } else if (remainder == 1) {
      status = 'Pendiente';
      statusColor = Colors.orange;
    } else {
      status = 'Denegado';
      statusColor = Colors.red;
    }

    return GestureDetector(
      // CORRECCIÓN: Aquí es donde navegamos al carrusel de analíticas
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoAnalyticsScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3), // Color Gris Skeleton
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // 1. Icono central (Placeholder)
            Center(
              child: Icon(
                Icons.play_circle_fill,
                color: Colors.grey[300],
                size: 40,
              ),
            ),

            // 2. Badge de Estado (Dinámico)
            Positioned(
              top: 6, right: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // 3. Vistas
            Positioned(
              top: 6, left: 6,
              child: Row(
                children: [
                  const Icon(Icons.remove_red_eye, color: Colors.grey, size: 12),
                  const SizedBox(width: 4),
                  Text(
                      '${(index + 1) * 215}',
                      style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)
                  ),
                ],
              ),
            ),

            // 4. Precio Pill
            Positioned(
              bottom: 8, left: 10, right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
                    ]
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.person, size: 10, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}