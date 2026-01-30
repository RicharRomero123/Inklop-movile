import 'package:flutter/material.dart';
import 'widgets/search_result_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Simula que el usuario ya escribió "Inklop" para mostrar resultados
    _searchController.text = "Inklop";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. HEADER DE BÚSQUEDA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Colors.black, width: 1), // Borde negro fino
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true, // Abre el teclado automáticamente
                        decoration: const InputDecoration(
                          hintText: 'Busca...',
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
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

            const SizedBox(height: 10),

            // 2. RESULTADOS
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: const [
                  // SECCIÓN: CUENTAS
                  Text('Cuentas', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500)),
                  SizedBox(height: 16),

                  SearchResultItem(
                    title: 'Inklop',
                    subtitle: '@inklop.pe',
                    isCampaign: false,
                  ),

                  SizedBox(height: 24),

                  // SECCIÓN: CAMPAÑAS
                  Text('Campañas', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500)),
                  SizedBox(height: 16),

                  SearchResultItem(
                    title: 'Creadores Inklop',
                    subtitle: '@inklop.pe',
                    isCampaign: true,
                    priceTag: 'S/20 / 1K',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}