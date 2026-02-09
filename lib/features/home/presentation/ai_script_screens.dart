import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para copiar al portapapeles

// --- PANTALLA 1: GENERANDO (LOADING) ---
class GeneratingScriptScreen extends StatefulWidget {
  const GeneratingScriptScreen({super.key});

  @override
  State<GeneratingScriptScreen> createState() => _GeneratingScriptScreenState();
}

class _GeneratingScriptScreenState extends State<GeneratingScriptScreen> {
  @override
  void initState() {
    super.initState();
    // Simulamos un proceso de 3 segundos y luego vamos al resultado
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ScriptResultScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Botón atrás
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animación simple de escala
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0.8, end: 1.1),
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9F9F9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 20,
                                spreadRadius: 5,
                              )
                            ],
                          ),
                          child: const Icon(Icons.auto_awesome, size: 30, color: Colors.black),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Generando el guión',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Analizando los datos de la campaña y el brief para darte un guión único y viral.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- PANTALLA 2: RESULTADO (GUION) ---
class ScriptResultScreen extends StatelessWidget {
  const ScriptResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // El texto del guion
    const String scriptText = """
🎬 GUION PROMOCIONAL PARA INKLOP - "Tu contenido, tus reglas, tus ingresos"

🎙️ VOZ EN OFF (enérgica):
¿Eres creador de contenido? ¿Compartes ideas, arte o conocimientos todos los días... pero aún no sabes cómo monetizarlo?

[Escena 2 – Creador frustrado frente a su celular o laptop, viendo que su contenido tiene likes pero no ingresos]

🎙️ VOZ EN OFF:
¡Eso se acabó! Con Inklop, convierte cada publicación en una oportunidad real de ingresos.

[Escena 3 – Transición visual de la interfaz de la app: dashboard, sección de ingresos, comunidad de creadores]

🎙️ VOZ EN OFF:
Inklop es la plataforma donde tú decides qué contenido compartes y cómo lo monetizas: suscripciones, pagos por acceso, o incluso recompensas directas de tus seguidores.

[Escena 4 – Creadora sonriendo mientras recibe una notificación de ingreso / fondos en la app]

🎙️ VOZ EN OFF:
¿Tienes talento para escribir, ilustrar, hacer tutoriales o simplemente inspirar? Inklop convierte tu pasión en ingresos reales.

[Escena 5 – Comentarios positivos de la comunidad en la app, usuarios interactuando]

🎙️ VOZ EN OFF:
Ya estás solo. Únete a una comunidad de creadores que ya están viviendo de lo que aman.

[Cierre - Logo de Inklop con CTA]
Descarga Inklop hoy y empieza a ganar.
""";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Color(0xFFF5F5F5), shape: BoxShape.circle),
          child: const Icon(Icons.auto_awesome, color: Colors.black, size: 20),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              '¡Guión generado!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // CONTENEDOR DEL TEXTO (SCROLLABLE)
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24), // Un poco más de padding interno
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    scriptText,
                    style: const TextStyle(
                      // CAMBIO AQUI: Quitamos fontFamily: 'Courier'
                      fontSize: 15, // Letra un poco más grande
                      height: 1.5,  // Altura de línea cómoda
                      color: Colors.black87, // Color negro suave, no gris
                      fontWeight: FontWeight.w400, // Peso normal
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // BOTONES INFERIORES
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  // Botón Copiar
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Clipboard.setData(const ClipboardData(text: scriptText));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Guión copiado al portapapeles')),
                          );
                        },
                        icon: const Icon(Icons.copy, size: 20, color: Colors.black),
                        label: const Text('Copiar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Botón Generar Otro
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: FilledButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const GeneratingScriptScreen()),
                          );
                        },
                        icon: const Icon(Icons.auto_awesome, size: 20, color: Colors.white),
                        label: const Text('Generar Otro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF1A1A1A),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
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
}