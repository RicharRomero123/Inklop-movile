import 'package:flutter/material.dart';
// 1. IMPORTAR LA PANTALLA DE INTERESES
import 'edit_interests_screen.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Editar Perfil', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1. ZONA SCROLLABLE (El Formulario)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                  children: [
                    // Avatar
                    const CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://i.pravatar.cc/300')),
                    const SizedBox(height: 10),
                    const Text('Cesar Mesia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                    const SizedBox(height: 30),

                    _buildInput('Nombre de usuario', '@cesar.mesia'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildInput('Nombre', 'Cesar')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildInput('Apellido', 'Mesia')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInput('Bio', 'Soy el CPO de @Inklop y que va pasar', maxLines: 4),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildInput('País', 'Perú')),
                        const SizedBox(width: 16),
                        Expanded(child: _buildInput('Ciudad', 'Lima')),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // --- NUEVO BOTÓN PARA EDITAR INTERESES ---
                    // Lo diseñamos parecido a los inputs para mantener coherencia
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Mis Intereses', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: () {
                            // NAVEGACIÓN A EDITAR INTERESES
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => const EditInterestsScreen())
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Gaming, Tech, Education...', style: TextStyle(fontSize: 14)), // Preview o texto fijo
                                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ------------------------------------------

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // 2. ZONA FIJA (Los Botones)
            Container(
              padding: const EdgeInsets.all(24),
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
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          side: const BorderSide(color: Colors.black)
                      ),
                      child: const Text('Cancelar', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF1A1A1A),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text('Guardar Cambios', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, String initialValue, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: initialValue,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}