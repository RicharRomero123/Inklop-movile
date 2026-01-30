import 'package:flutter/material.dart';
import 'role_selection_screen.dart';
class BirthDateScreen extends StatefulWidget {
  const BirthDateScreen({super.key});

  @override
  State<BirthDateScreen> createState() => _BirthDateScreenState();
}

class _BirthDateScreenState extends State<BirthDateScreen> {
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // 1. Icono Pastel
              Center(
                child: Container(
                  height: 60,
                  width: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/icon_cake_header.png'),
                ),
              ),
              const SizedBox(height: 20),

              // 2. Títulos
              const Text(
                'Ingresa tu fecha de nacimiento',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Para verificar tu edad, por favor ingresa la fecha de nacimiento',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // 3. Input Fecha
              Container(
                width: 250,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F3F3),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _dateController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.datetime,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    hintText: 'DD / MM / AA',
                    hintStyle: TextStyle(color: Colors.grey, letterSpacing: 2),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    // Aquí podrías agregar lógica para auto-formatear los slashes (/)
                    setState(() {});
                  },
                ),
              ),

              const Spacer(),

              // 4. Botón Continuar
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                    onPressed: _dateController.text.isNotEmpty
                        ? () {
                      // Navegamos a la selección de ROL
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const RoleSelectionScreen()));
                    }
                        : null,

                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    disabledBackgroundColor: const Color(0xFFF3F3F3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    'Continuar',
                    style: TextStyle(
                        color: _dateController.text.isNotEmpty ? Colors.white : Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}