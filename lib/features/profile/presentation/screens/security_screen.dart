import 'package:flutter/material.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

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
        title: const Text('Seguridad', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Contraseña', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.lock, color: Colors.black),
                title: Text('Cambiar contraseña', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Actualiza tu contraseña regularmente para mayor seguridad', style: TextStyle(fontSize: 12, color: Colors.grey)),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}