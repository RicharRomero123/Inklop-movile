import 'package:flutter/material.dart';
import 'explore_screen.dart';

// --- IMPORTACIONES DE TUS PANTALLAS ---
import '../../dashboard/presentation/dashboard_screen.dart';
import '../../payments/presentation/payments_screen.dart';
import '../../profile/presentation/profile_screen.dart'; // <--- 1. IMPORTAR PERFIL

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // 2. LISTA ACTUALIZADA CON TODAS LAS PANTALLAS REALES
  final List<Widget> _screens = [
    const ExploreScreen(),    // Index 0
    const DashboardScreen(),  // Index 1
    const PaymentsScreen(),   // Index 2
    const ProfileScreen(),    // Index 3 (¡Conectado!)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Extendemos el cuerpo detrás del navbar para que se vea limpio si hay transparencia
      extendBody: true,

      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // 3. BARRA DE NAVEGACIÓN CON BORDES REDONDEADOS
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), // Curva superior izquierda
            topRight: Radius.circular(30), // Curva superior derecha
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08), // Sombra suave
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        // Usamos ClipRRect para recortar el BottomNavigationBar real
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore),
                label: 'Explorar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                activeIcon: Icon(Icons.account_balance_wallet),
                label: 'Mis Pagos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Mi perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}