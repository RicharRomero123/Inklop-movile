import 'package:flutter/material.dart';
import 'package:inklop/features/auth/presentation/main_screen.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final Set<String> _selectedInterests = {'Gaming', 'Lifestyle'};

  // MAPA DE ICONOS
  final Map<String, String> _interestIcons = {
    'Grabación de Contenido': 'assets/images/ic_video.png',
    'Clipping': 'assets/images/ic_clipping.png',
    'Gaming': 'assets/images/ic_gaming.png',
    'Podcast': 'assets/images/ic_podcast.png',
    'Education': 'assets/images/ic_education.png',
    'Foodie': 'assets/images/ic_foodie.png',
    'Travels': 'assets/images/ic_travels.png',
    'Fashion': 'assets/images/ic_fashion.png',
    'Beauty': 'assets/images/ic_beauty.png',
    'Fitness': 'assets/images/ic_fitness.png',
    'Lifestyle': 'assets/images/ic_lifestyle.png',
  };

  final List<String> _contentInterests = ['Grabación de Contenido', 'Clipping'];
  final List<String> _typeInterests = ['Gaming', 'Podcast', 'Education', 'Foodie', 'Travels', 'Fashion', 'Beauty', 'Fitness', 'Lifestyle'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // AVATAR
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/user_avatar.png'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.grey.shade200, width: 1),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text('@cesar.mesia', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),

                    const SizedBox(height: 25),

                    // TEXTOS
                    const Text('Sobre tus intereses', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      '¿Qué es lo que te interesa más explorar en nuestra app?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                    ),
                    const SizedBox(height: 35),

                    // SECCIÓN 1: DOS COLUMNAS
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Intereses de Contenido', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade800)),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 3.8, // Más ancho para que no se vea cuadrado
                      ),
                      itemCount: _contentInterests.length,
                      itemBuilder: (context, index) {
                        return _buildPillButton(_contentInterests[index]);
                      },
                    ),

                    const SizedBox(height: 24),

                    // SECCIÓN 2: TRES COLUMNAS
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Tipo de Contenido', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade800)),
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2.4, // Ajustado para forma de cápsula perfecta
                      ),
                      itemCount: _typeInterests.length,
                      itemBuilder: (context, index) {
                        return _buildPillButton(_typeInterests[index]);
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // BOTÓN CONTINUAR
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                          (route) => false,
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Botón principal muy redondo
                    ),
                    elevation: 0,
                  ),
                  child: const Text('Continuar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPillButton(String label) {
    final isSelected = _selectedInterests.contains(label);

    // Colores exactos de la referencia
    final backgroundColor = isSelected ? Colors.black : const Color(0xFFF8F8F8);
    final textColor = isSelected ? Colors.white : const Color(0xFF9E9E9E);
    final iconColor = isSelected ? Colors.white : const Color(0xFFBDBDBD);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedInterests.remove(label);
          } else {
            _selectedInterests.add(label);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
          // AQUÍ ESTÁ EL CAMBIO CLAVE: Radio alto para efecto cápsula/pastilla
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              _interestIcons[label] ?? 'assets/images/ic_default.png',
              width: 16, // Icono un poco más sutil
              height: 16,
              color: iconColor,
              errorBuilder: (ctx, err, stack) => Icon(Icons.circle, size: 6, color: iconColor),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12.5, // Fuente ajustada para encajar bien
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}