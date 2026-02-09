import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// IMPORTANTE: Asegúrate de importar la pantalla de intereses aquí
import 'interests_screen.dart';

class CreatorProfileScreen extends StatefulWidget {
  const CreatorProfileScreen({super.key});

  @override
  State<CreatorProfileScreen> createState() => _CreatorProfileScreenState();
}

class _CreatorProfileScreenState extends State<CreatorProfileScreen> {
  // Variable para guardar la foto seleccionada
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Función para abrir la galería
  Future<void> _pickImage() async {
    final XFile? returnedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
    }
  }

  final Map<String, FocusNode> _focusNodes = {
    'username': FocusNode(),
    'nombre': FocusNode(),
    'apellido': FocusNode(),
    'bio': FocusNode(),
    'pais': FocusNode(),
    'ciudad': FocusNode(),
  };

  final Map<String, TextEditingController> _controllers = {
    'username': TextEditingController(),
    'nombre': TextEditingController(),
    'apellido': TextEditingController(),
    'bio': TextEditingController(),
    'pais': TextEditingController(),
    'ciudad': TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    _focusNodes.forEach((key, node) {
      node.addListener(() => setState(() {}));
    });
  }

  @override
  void dispose() {
    _focusNodes.forEach((key, node) => node.dispose());
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  // Validar si los campos mínimos están llenos para habilitar el botón (Opcional)
  bool get _isFormValid {
    // Puedes ajustar esto según qué campos sean obligatorios
    return _controllers['username']!.text.isNotEmpty &&
        _controllers['nombre']!.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 50,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFFF8F8F8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 14),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [

              // --- FOTO DE PERFIL ---
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF2F2F2),
                          shape: BoxShape.circle,
                          image: _selectedImage != null
                              ? DecorationImage(
                            image: FileImage(_selectedImage!),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                        child: _selectedImage == null
                            ? const Icon(
                          Icons.person,
                          size: 55,
                          color: Colors.black,
                        )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0E0E0),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: const Icon(Icons.edit, size: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Completa Tu Perfil',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
              ),
              const SizedBox(height: 4),
              const Text(
                'Date a conocer a otros creadores',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // --- FORMULARIO ---
              _buildInput(label: 'Nombre de usuario', hint: '@username', keyName: 'username'),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(child: _buildInput(label: 'Nombre', hint: 'Nombre', keyName: 'nombre')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildInput(label: 'Apellido', hint: 'Apellido', keyName: 'apellido')),
                ],
              ),
              const SizedBox(height: 12),

              _buildInput(label: 'Bio', hint: 'Comparte algo curioso', keyName: 'bio', isBio: true),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(child: _buildInput(label: 'País', hint: 'País', keyName: 'pais')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildInput(label: 'Ciudad', hint: 'Ciudad', keyName: 'ciudad')),
                ],
              ),

              const Spacer(),

              // --- BOTÓN CONTINUAR ---
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () {
                    // Aquí navegamos a la pantalla de intereses
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const InterestsScreen())
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('Continuar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required String hint,
    required String keyName,
    bool isBio = false,
  }) {
    final focusNode = _focusNodes[keyName]!;
    final controller = _controllers[keyName]!;
    bool isActive = focusNode.hasFocus || controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFFADADAD), fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 6),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7),
            borderRadius: BorderRadius.circular(isBio ? 15 : 30),
            border: Border.all(
              color: isActive ? const Color(0xFFE0E0E0) : const Color(0xFFF3F3F3),
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            maxLines: isBio ? 3 : 1,
            onChanged: (val) => setState(() {}),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFFADADAD), fontWeight: FontWeight.normal, fontSize: 14),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: isBio ? 12 : 14),
            ),
          ),
        ),
      ],
    );
  }
}