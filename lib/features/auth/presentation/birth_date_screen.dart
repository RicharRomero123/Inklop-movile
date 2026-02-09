import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Asegúrate de que esta ruta sea correcta en tu proyecto
import 'package:inklop/features/auth/presentation/creator_profile_screen.dart';

class BirthDateScreen extends StatefulWidget {
  const BirthDateScreen({super.key});

  @override
  State<BirthDateScreen> createState() => _BirthDateScreenState();
}

class _BirthDateScreenState extends State<BirthDateScreen> {
  final _dateController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isDateValid = false;
  // Variable nueva para mostrar el mensaje de error visualmente
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _dateController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validateDate(String value) {
    // 1. Validar longitud
    if (value.length != 14) {
      if (_isDateValid) {
        setState(() {
          _isDateValid = false;
          _errorText = null; // Limpiamos error si está escribiendo
        });
      }
      return;
    }

    try {
      // 2. Parsear fecha
      List<String> parts = value.replaceAll(' ', '').split('/');
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      final now = DateTime.now();

      // Validaciones básicas de existencia de fecha
      if (year < 1900 || year > now.year) throw Exception();
      if (month < 1 || month > 12) throw Exception();

      int daysInMonth(int m, int y) {
        if (m == 2) return (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)) ? 29 : 28;
        const days = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        return days[m];
      }

      if (day < 1 || day > daysInMonth(month, year)) throw Exception();

      // --- 3. VALIDACIÓN DE MAYORÍA DE EDAD (18 AÑOS) ---
      final dob = DateTime(year, month, day);
      int age = now.year - dob.year;

      // Si el mes actual es menor al mes de nacimiento,
      // o si es el mismo mes pero el día actual es menor al día de nacimiento,
      // restamos 1 año porque aún no ha cumplido años.
      if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
        age--;
      }

      if (age < 18) {
        setState(() {
          _isDateValid = false;
          _errorText = "Debes ser mayor de 18 años para registrarte.";
        });
        return; // Detenemos aquí
      }
      // ----------------------------------------------------

      // Si pasa todo, es válido
      setState(() {
        _isDateValid = true;
        _errorText = null;
      });

    } catch (e) {
      setState(() {
        _isDateValid = false;
        // Si la fecha es inválida (ej: mes 13), limpiamos el error de edad
        // para no confundir, o podrías poner "Fecha inválida".
        _errorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isActive = _focusNode.hasFocus || _dateController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 8),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF8F8F8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 16),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Icono Pastel
              Center(
                child: Container(
                  height: 64,
                  width: 64,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/icon_cake_header.png',
                      height: 32,
                      errorBuilder: (c, o, s) => const Icon(Icons.cake, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Ingresa tu fecha de nacimiento',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Para verificar tu edad, por favor ingresa la fecha de nacimiento',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey, height: 1.4),
              ),
              const SizedBox(height: 40),

              // Input Fecha
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 280,
                  height: 68,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(35),
                    // Si hay error de edad, pintamos el borde rojo
                    border: Border.all(
                      color: _errorText != null
                          ? Colors.redAccent
                          : (isActive ? const Color(0xFFE0E0E0) : const Color(0xFFF3F3F3)),
                      width: 1.5,
                    ),
                  ),
                  child: TextField(
                    controller: _dateController,
                    focusNode: _focusNode,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                      BirthDateInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                      hintText: 'DD / MM / AAAA',
                      hintStyle: TextStyle(
                        color: Color(0xFFADADAD),
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0,
                      ),
                      border: InputBorder.none,
                      counterText: "",
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) => _validateDate(value),
                  ),
                ),
              ),

              // --- Mensaje de Error (Nuevo) ---
              if (_errorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    _errorText!,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

              const Spacer(),

              // Botón Continuar
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  // Solo permite continuar si es válida (incluyendo > 18 años)
                  onPressed: _isDateValid
                      ? () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreatorProfileScreen()))
                      : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1A1A1A),
                    disabledBackgroundColor: const Color(0xFFF1F1F1),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'Continuar',
                    style: TextStyle(
                      color: _isDateValid ? Colors.white : const Color(0xFFADADAD),
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
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

// El formatter se mantiene igual
class BirthDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    var buffer = StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex == 2 && nonZeroIndex != newText.length) {
        buffer.write(' / ');
      } else if (nonZeroIndex == 4 && nonZeroIndex != newText.length) {
        buffer.write(' / ');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}