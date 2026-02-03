import 'package:flutter/material.dart';

class LinkedAccountsScreen extends StatelessWidget {
  const LinkedAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D0052),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Mis Cuentas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Cuentas Conectadas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          _buildAccountCard('Cesar Mesia', '@cesar.mesia', Icons.tiktok, true),
          _buildAccountCard('Inklop Journey', '@inklop.journey', Icons.tiktok, true),

          const SizedBox(height: 30),
          const Text('Pendiente a Verificación', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          // CARD PENDIENTE ESPECIAL
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.tiktok, size: 30),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Inklop', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('@inklop.pe', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Container(width: 1, height: 30, color: Colors.grey.shade300),
                        const SizedBox(width: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Código de verificación', style: TextStyle(fontSize: 8, color: Colors.grey)),
                            Row(
                              children: [
                                Text('7JEIC5', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                SizedBox(width: 4),
                                Icon(Icons.copy, size: 14, color: Colors.grey),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const Icon(Icons.delete, color: Colors.purple),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.black, Colors.black87]),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: const Center(child: Text('Verificar', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
                )
              ],
            ),
          ),

          const SizedBox(height: 30),
          const Text('Conectar Cuentas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          _buildConnectRow('TikTok', Icons.tiktok),
          const SizedBox(height: 12),
          _buildConnectRow('Instagram', Icons.camera_alt),
        ],
      ),
    );
  }

  Widget _buildAccountCard(String name, String handle, IconData icon, bool isConnected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 30),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(handle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),
          Icon(Icons.delete, color: Colors.grey.shade600),
        ],
      ),
    );
  }

  Widget _buildConnectRow(String platform, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 24),
              const SizedBox(width: 12),
              Text(platform, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20)),
            child: const Text('Conectar', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}