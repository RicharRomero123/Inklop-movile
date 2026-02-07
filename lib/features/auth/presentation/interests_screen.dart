import 'package:flutter/material.dart';
import 'package:inklop/features/auth/presentation/main_screen.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  // Estado para los intereses seleccionados
  final Set<String> _selectedInterests = {'Gaming', 'Lifestyle'};

  // MAPA DE ICONOS CORREGIDO (Ruta: assets/images/)
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF8F8F8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 16),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        // Avatar Responsivo
                        Center(
                          child: Column(
                            children: [
                              Container(
                                height: 85,
                                width: 85,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: AssetImage('assets/images/user_avatar.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: const Color(0xFFF3F3F3), width: 2),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text('@cesar.mesia', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Sobre tus intereses', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text(
                          '¿Qué es lo que te interesa más explorar en nuestra app?',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        const SizedBox(height: 32),

                        _buildSectionTitle('Intereses de Contenido'),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: _contentInterests.map((i) => _buildInterestChip(i)).toList(),
                          ),
                        ),

                        const SizedBox(height: 32),

                        _buildSectionTitle('Tipo de Contenido'),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: _typeInterests.map((i) => _buildInterestChip(i)).toList(),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Botón Continuar Fijo
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const MainScreen()),
                              (route) => false,
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF1A1A1A),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Continuar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildInterestChip(String label) {
    final isSelected = _selectedInterests.contains(label);

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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D1D1D) : const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.black : const Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // CARGA DE ICONO PNG CON TINTA DINÁMICA
            Image.asset(
              _interestIcons[label] ?? 'assets/images/ic_default.png',
              height: 18,
              width: 18,
              color: isSelected ? Colors.white : const Color(0xFFADADAD),
              // Esto evita que la app truene si olvidas poner un icono en la carpeta
              errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.star_outline,
                  size: 18,
                  color: isSelected ? Colors.white : const Color(0xFFADADAD)
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF707070),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}