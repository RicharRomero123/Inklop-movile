import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// --- MODAL 1: INGRESAR URL ---
void showLinkAccountSheet(BuildContext context, VoidCallback onNext) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Para que suba con el teclado
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Vincula tu cuenta de TikTok', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'Pega aquí tu el URL de tu cuenta de tiktok para verificar y generar un código de verificación',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 20),
          const Text('URL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'www.tiktok.com/@username',
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.grey)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          const SizedBox(height: 24),

          // BOTONES
          SizedBox(
            width: double.infinity, height: 50,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context); // Cierra este modal
                onNext(); // Abre el siguiente
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.black),
              child: const Text('Añadir', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity, height: 50,
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFF0F0F0),
                foregroundColor: Colors.black,
              ),
              child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    ),
  );
}

// --- MODAL 2: VERIFICACIÓN PENDIENTE (CÓDIGO) ---
void showVerificationSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Verificación Pendiente', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'Para completar la verificación debes colocar el código en tu biografía o descripción de perfil para verificar tu cuenta',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
          const SizedBox(height: 20),

          // CARD DE CUENTA
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.tiktok, size: 20),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TikTok', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    Text('@inklop.journey', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.edit, size: 16, color: Colors.grey),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // CÓDIGO DE COPIA
          Row(
            children: [
              const Text('7JEIC5', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(const ClipboardData(text: "7JEIC5"));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Código copiado")));
                },
                child: const Icon(Icons.copy, size: 20, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.info, size: 14, color: Colors.black),
              SizedBox(width: 6),
              Expanded(child: Text('Una vez verificado el código puedes eliminarlo de tu biografía', style: TextStyle(fontSize: 11, color: Colors.grey))),
            ],
          ),

          const SizedBox(height: 30),

          // BOTONES
          SizedBox(
            width: double.infinity, height: 50,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context);
                // Aquí iría la lógica de éxito
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("¡Cuenta Verificada!")));
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.black),
              child: const Text('Verificar', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity, height: 50,
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFFF0F0F0), foregroundColor: Colors.black),
              child: const Text('Más tarde', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    ),
  );
}