import 'package:flutter/material.dart';
import 'explore_screen.dart';

// 1. IMPORTANTE: Importar la pantalla del Dashboard
// Ajusta la ruta si tu carpeta es diferente, pero según lo que creamos debería ser esta:
import '../../dashboard/presentation/dashboard_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // 2. ACTUALIZAMOS LA LISTA DE VISTAS
  final List<Widget> _screens = [
    const ExploreScreen(),   // Index 0: Explorar
    const DashboardScreen(), // Index 1: Dashboard (¡Conectado!)
    const Scaffold(body: Center(child: Text("Mis Pagos"))), // Index 2 (Pendiente)
    const Scaffold(body: Center(child: Text("Mi Perfil"))), // Index 3 (Pendiente)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos IndexedStack para mantener el estado de las vistas
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // BARRA DE NAVEGACIÓN INFERIOR
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
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
    );
  }
}