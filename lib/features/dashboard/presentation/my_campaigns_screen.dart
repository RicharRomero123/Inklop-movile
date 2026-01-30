import 'package:flutter/material.dart';
import 'widgets/my_campaign_card.dart';

class MyCampaignsScreen extends StatefulWidget {
  const MyCampaignsScreen({super.key});

  @override
  State<MyCampaignsScreen> createState() => _MyCampaignsScreenState();
}

class _MyCampaignsScreenState extends State<MyCampaignsScreen> {
  int _selectedTab = 0; // 0: Activas, 1: Finalizadas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          // 1. HEADER MORADO
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 20),
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
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Mis Campañas',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // 2. TABS (TEXTO)
          Container(
            color: const Color(0xFFF9F9F9), // Fondo para fundirse
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Row(
              children: [
                _buildTextTab('Activas', 0),
                const SizedBox(width: 20),
                _buildTextTab('Finalizadas', 1),
              ],
            ),
          ),

          // 3. LISTA DE CAMPAÑAS
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: _selectedTab == 0 ? _buildActiveList() : _buildFinishedList(),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildTextTab(String text, int index) {
    bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          // Línea de subrayado animada (simple)
          Container(
            height: 2,
            width: isSelected ? 30 : 0,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActiveList() {
    return [
      const MyCampaignCard(title: 'Creadores Inklop', brand: '@inklop.pe', price: 'S/20/1K'),
      const MyCampaignCard(title: 'Navidad con Topitop', brand: '@topitop.pe', price: 'S/20/1K'),
      const MyCampaignCard(title: 'Promo Rokys', brand: '@rokys.pe', price: 'S/50/1K'),
      const MyCampaignCard(title: 'Creadores Inklop', brand: '@inklop.pe', price: 'S/20/1K'),

      const SizedBox(height: 20),
      const Center(
          child: Text(
              'Cargar más',
              style: TextStyle(decoration: TextDecoration.underline, fontSize: 12)
          )
      ),
      const SizedBox(height: 40),
    ];
  }

  List<Widget> _buildFinishedList() {
    return [
      const MyCampaignCard(title: 'Campaña Escolar', brand: '@tailoy.pe', price: 'S/15/1K', isFinished: true),
      const MyCampaignCard(title: 'Verano 2024', brand: '@helados.pe', price: 'S/30/1K', isFinished: true),
    ];
  }
}