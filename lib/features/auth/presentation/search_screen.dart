import 'package:flutter/material.dart';
import 'widgets/search_result_item.dart'; // Asegúrate de que esta ruta siga siendo correcta

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // 0 = Cuentas, 1 = Campañas
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    // Simula búsqueda inicial
    _searchController.text = "Makeup";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===============================================
            // 1. HEADER DE BÚSQUEDA
            // ===============================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12), // Bordes un poco menos redondos para parecerse a iOS
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child: TextField(
                        controller: _searchController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          hintText: 'Busca...',
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            // ===============================================
            // 2. PESTAÑAS (TABS) - CUENTAS | CAMPAÑAS
            // ===============================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                children: [
                  _buildTabItem(label: "Cuentas", index: 0),
                  const SizedBox(width: 20),
                  _buildTabItem(label: "Campañas", index: 1),
                ],
              ),
            ),

            // Línea divisoria sutil (opcional, para separar tabs del contenido)
            Divider(height: 1, color: Colors.grey.shade200),

            // ===============================================
            // 3. LISTA DE RESULTADOS (CAMBIA SEGÚN EL TAB)
            // ===============================================
            Expanded(
              child: _selectedTab == 0
                  ? _buildAccountsList()
                  : _buildCampaignsList(),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET PARA CADA PESTAÑA ---
  Widget _buildTabItem({required String label, required int index}) {
    final bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 8), // Espacio para la línea inferior
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(bottom: BorderSide(color: Colors.black, width: 2))
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  // --- LISTA DE CUENTAS (TAB 0) ---
  Widget _buildAccountsList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      children: const [
        // Ejemplos estáticos basados en tu imagen
        SearchResultItem(
          title: 'Olivia Mendoza',
          subtitle: '@makeup.olivia',
          isCampaign: false,
          // Si tu widget soporta imagen, podrías pasarla aquí
          // imageUrl: '...',
        ),
        SizedBox(height: 16),
        SearchResultItem(
          title: 'Valeria Makeup',
          subtitle: '@mk.val',
          isCampaign: false,
        ),
        SizedBox(height: 16),
        SearchResultItem(
          title: 'makeupwithclara',
          subtitle: '@itsclara',
          isCampaign: false,
        ),
        SizedBox(height: 16),
        SearchResultItem(
          title: 'Inklop',
          subtitle: '@inklop.pe',
          isCampaign: false,
        ),
      ],
    );
  }

  // --- LISTA DE CAMPAÑAS (TAB 1) ---
  Widget _buildCampaignsList() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      children: const [
        // Ejemplos de campañas
        SearchResultItem(
          title: 'Campaña Maquillaje Verano',
          subtitle: '@makeup.olivia',
          isCampaign: true,
          priceTag: 'S/100 / 1 Video',
        ),
        SizedBox(height: 16),
        SearchResultItem(
          title: 'Creadores Inklop',
          subtitle: '@inklop.pe',
          isCampaign: true,
          priceTag: 'S/20 / 1K',
        ),
        SizedBox(height: 16),
        SearchResultItem(
          title: 'Navidad con Topitop',
          subtitle: '@topitop.pe',
          isCampaign: true,
          priceTag: 'S/50 / 1K',
        ),
      ],
    );
  }
}