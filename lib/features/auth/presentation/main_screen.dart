import 'package:flutter/material.dart';
import 'package:inklop/features/mensages/presentation/messages_screen.dart';
import 'explore_screen.dart';

// IMPORTACIONES
import '../../dashboard/presentation/dashboard_screen.dart';
import '../../payments/presentation/payments_screen.dart';
import '../../profile/presentation/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ExploreScreen(),
    const MessagesScreen(),
    const DashboardScreen(),
    const PaymentsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Esto permite que el body se vea detrás del navbar
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        // 1. Altura ajustada y ALINEACIÓN CENTRAL
        height: 90,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF000000), Color(0xFF2D0052)],
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, blurRadius: 15, offset: Offset(0, -5))
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          // 2. Theme para quitar el splash y ajustar densidades
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,

              // Colores
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white60,

              // 3. Ajuste de estilos de texto para que queden más compactos
              selectedFontSize: 11,
              unselectedFontSize: 11,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, height: 1.2),
              unselectedLabelStyle: const TextStyle(height: 1.2),

              items: [
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/images/ic_explore.png', false),
                  activeIcon: _buildIcon('assets/images/ic_explore_filled.png', true),
                  label: 'Explorar',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/images/ic_messages.png', false),
                  activeIcon: _buildIcon('assets/images/ic_messages_filled.png', true),
                  label: 'Mensajes',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/images/ic_dashboard.png', false),
                  activeIcon: _buildIcon('assets/images/ic_dashboard_filled.png', true),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/images/ic_wallet.png', false),
                  activeIcon: _buildIcon('assets/images/ic_wallet_filled.png', true),
                  label: 'Mis Pagos',
                ),
                BottomNavigationBarItem(
                  icon: _buildIcon('assets/images/ic_profile.png', false),
                  activeIcon: _buildIcon('assets/images/ic_profile_filled.png', true),
                  label: 'Mi perfil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(String assetPath, bool isActive) {
    // 4. Padding reducido para juntar icono y texto
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Image.asset(
        assetPath,
        width: 24,
        height: 24,
        color: isActive ? Colors.white : Colors.white60,
      ),
    );
  }
}