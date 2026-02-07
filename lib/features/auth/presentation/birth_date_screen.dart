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
  final FocusNode _focusNode = FocusNode(); // Para el borde dinámico
  bool _isDateValid = false;

  @override
  void initState() {
    super.initState();
    // Escuchamos el foco para redibujar el borde
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _dateController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _validateDate(String value) {
    // La longitud ahora es 14 debido a los espacios "DD / MM / AAAA"
    if (value.length != 14) {
      if (_isDateValid) setState(() => _isDateValid = false);
      return;
    }

    try {
      // Limpiamos espacios para validar los números puros
      List<String> parts = value.replaceAll(' ', '').split('/');
      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      final now = DateTime.now();
      if (year < 1900 || year > now.year) throw Exception();
      if (month < 1 || month > 12) throw Exception();

      int daysInMonth(int m, int y) {
        if (m == 2) return (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)) ? 29 : 28;
        const days = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        return days[m];
      }

      if (day < 1 || day > daysInMonth(month, year)) throw Exception();
      setState(() => _isDateValid = true);
    } catch (e) {
      setState(() => _isDateValid = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // El borde se activa si tiene foco o ya tiene texto
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
              // 1. Icono Pastel Header
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

              // 3. Input Fecha (Mismo tamaño y formato que OTP)
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 280, // Ancho suficiente para DD / MM / AAAA
                  height: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color: isActive ? const Color(0xFFE0E0E0) : const Color(0xFFF3F3F3),
                      width: 1.5,
                    ),
                  ),
                  child: TextField(
                    controller: _dateController,
                    focusNode: _focusNode,
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center, // Centrado vertical
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 22, // Un poco más pequeño que OTP para que quepa bien
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      height: 1.0,
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
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: _validateDate,
                  ),
                ),
              ),

              const Spacer(),

              // 4. Botón Continuar
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
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

class BirthDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    var buffer = StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;

      // Agregamos " / " con espacios para mejorar el diseño
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