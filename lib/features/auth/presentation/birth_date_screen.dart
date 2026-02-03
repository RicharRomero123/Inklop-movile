import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inklop/features/auth/presentation/creator_profile_screen.dart';

class BirthDateScreen extends StatefulWidget {
  const BirthDateScreen({super.key});

  @override
  State<BirthDateScreen> createState() => _BirthDateScreenState();
}

class _BirthDateScreenState extends State<BirthDateScreen> {
  final _dateController = TextEditingController();
  bool _isDateValid = false;

  // Lógica de validación exacta para DD/MM/AAAA
  void _validateDate(String value) {
    // Debe tener exactamente 10 caracteres (DD/MM/AAAA)
    if (value.length != 10) {
      if (_isDateValid) setState(() => _isDateValid = false);
      return;
    }

    try {
      List<String> parts = value.split('/');
      if (parts.length != 3) throw Exception();

      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      final now = DateTime.now();

      // Validaciones lógicas
      if (year < 1900 || year > now.year - 10) throw Exception(); // Al menos 10 años? (Opcional)
      if (month < 1 || month > 12) throw Exception();

      // Días por mes exactos
      int daysInMonth(int m, int y) {
        if (m == 2) {
          // Año bisiesto
          return (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)) ? 29 : 28;
        }
        const days = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        return days[m]; // Fallback simple para meses normales
      }

      if (day < 1 || day > daysInMonth(month, year)) throw Exception();

      setState(() => _isDateValid = true);
    } catch (e) {
      setState(() => _isDateValid = false);
    }
  }

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
                  // Cambia el asset si no lo tienes
                  child: Image.asset('assets/images/icon_cake_header.png', errorBuilder: (c,o,s) => const Icon(Icons.cake, color: Colors.black)),
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

              // 3. Input Fecha AUTOMATIZADO
              Container(
                width: 250,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: _dateController.text.length == 10 && !_isDateValid
                            ? Colors.red
                            : Colors.transparent
                    )
                ),
                child: TextField(
                  controller: _dateController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  // Solo permitimos 10 caracteres (DD/MM/AAAA)
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Solo deja pasar números
                    LengthLimitingTextInputFormatter(8),    // Máximo 8 números (sin contar los /)
                    BirthDateInputFormatter(),              // <--- MAGIA AQUÍ
                  ],
                  decoration: const InputDecoration(
                    hintText: 'DD/MM/AAAA', // Formato visual sugerido
                    hintStyle: TextStyle(color: Colors.grey, letterSpacing: 1.5),
                    border: InputBorder.none,
                    counterText: "",
                  ),
                  onChanged: (value) {
                    _validateDate(value);
                  },
                ),
              ),

              if (_dateController.text.length == 10 && !_isDateValid)
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text("Fecha inválida", style: TextStyle(color: Colors.red, fontSize: 12)),
                ),

              const Spacer(),

              // 4. Botón Continuar
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _isDateValid
                      ? () {
                    // Navegación
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CreatorProfileScreen()));
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
                      color: _isDateValid ? Colors.white : Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

// -------------------------------------------------------------------
// CLASE FORMATTER ESTRICTO: DD/MM/AAAA
// -------------------------------------------------------------------
class BirthDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // 1. Obtenemos solo los números del nuevo texto
    // (Gracias al FilteringTextInputFormatter.digitsOnly previo, newValue ya debería ser solo números,
    // pero nos aseguramos por si acaso al reconstruir).
    final newText = newValue.text;

    // Si estamos borrando, permitimos borrar normal.
    // La magia es reconstruir la cadena desde cero con los números que quedan.

    // Buffer para construir la nueva cadena con /
    var buffer = StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;

      // Si llegamos al 2do dígito (DD) y no es el final, agregamos /
      if (nonZeroIndex == 2 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
      // Si llegamos al 4to dígito (MM) y no es el final, agregamos /
      else if (nonZeroIndex == 4 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();

    // Retornamos el valor formateado y mantenemos el cursor al final
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}