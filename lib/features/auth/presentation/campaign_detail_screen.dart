import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // NECESARIO PARA COPIAR AL PORTAPAPELES
import 'package:inklop/features/home/presentation/chat_list_screen.dart';
import 'package:inklop/features/home/presentation/my_submissions_screen.dart';
import 'dart:ui'; // Necesario para ImageFilter

// IMPORTS DE TU PROYECTO
import '../../home/domain/campaign_model.dart';

// TUS PANTALLAS EXTERNAS
import 'package:inklop/features/home/presentation/ai_script_screens.dart';
import 'package:inklop/features/home/presentation/send_video_screen.dart';


class CampaignDetailScreen extends StatefulWidget {
  final CampaignModel campaign;

  const CampaignDetailScreen({super.key, required this.campaign});

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  final DraggableScrollableController _sheetController = DraggableScrollableController();

  int _selectedTab = 0;
  bool _isJoined = false;

  // Estado para el efecto blur del logo
  bool _isBlurred = false;
  double _anchorSize = 0.5;

  @override
  void initState() {
    super.initState();
    _sheetController.addListener(_onSheetChanged);
  }

  @override
  void dispose() {
    _sheetController.removeListener(_onSheetChanged);
    _sheetController.dispose();
    super.dispose();
  }

  void _onSheetChanged() {
    if (!mounted) return;

    final currentSize = _sheetController.size;
    final double threshold = _anchorSize + 0.05;
    final bool shouldBlur = currentSize > threshold;

    if (_isBlurred != shouldBlur) {
      setState(() {
        _isBlurred = shouldBlur;
      });
    }
  }

  // --- NUEVA FUNCIÓN: MOSTRAR MODAL DE INSTRUCCIONES ---
  void _showInstructionsModal(BuildContext context) {
    // Texto extraído de tu imagen
    const String instructionsText = """
1. Objetivo del contenido
Dar a conocer Inklop como la plataforma donde creadores pueden monetizar su contenido de forma rápida, transparente y trabajando con marcas reales. El objetivo es generar descargas, registros y confianza.

2. Idea central / Mensaje clave
"Inklop te conecta con marcas que pagan por tu contenido. Monetiza sin complicarte."

3. Pilares de comunicación
1. Fácil de usar
   – Registro simple
   – Dashboard intuitivo
   – Seguimiento de métricas
2. Oportunidades reales de ingreso
   – Campañas pagadas
   – CPM competitivo
   – Trabajos con marcas y streamers
3. Rapidez y transparencia
   – Métricas claras
   – Proceso seguro
   – Pagos garantizados según performance
4. Acceso para creadores de todos los tamaños
   – No importa el número de seguidores
""";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite que el modal sea alto
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85, // 85% de la pantalla
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
            // Handle gris pequeño
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // CABECERA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFF222222), // Fondo oscuro icono
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.description, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Instrucciones de Contenido',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            const Divider(),

            // CONTENIDO SCROLLABLE
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Text(
                  instructionsText,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            // FOOTER CON BOTONES (Copiar / Entendido)
            Container(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 40),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
                ],
              ),
              child: Row(
                children: [
                  // Botón Copiar
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(const ClipboardData(text: instructionsText));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Copiado al portapapeles'), duration: Duration(seconds: 2)),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      icon: const Icon(Icons.copy_outlined, color: Colors.black, size: 20),
                      label: const Text('Copiar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Botón Entendido
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.pop(context),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xFF222222),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text('Entendido', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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

  @override
  Widget build(BuildContext context) {
    // --- MEDIDAS Y RESPONSIVIDAD ---
    final Size screenSize = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    const double headerHeight = 250.0;
    const double overlap = 45.0;
    final double topSafeArea = statusBarHeight + 70.0;

    final double maxSheetHeight = (screenSize.height - topSafeArea) / screenSize.height;
    final double initialSheetHeight = (screenSize.height - (headerHeight - overlap)) / screenSize.height;

    final double safeMax = maxSheetHeight.clamp(0.0, 1.0);
    final double safeInitial = initialSheetHeight.clamp(0.0, safeMax);

    // Actualizamos la referencia para el listener
    _anchorSize = safeInitial;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // 1. FONDO (IMAGEN CON BLUR)
          Positioned(
            top: 0, left: 0, right: 0,
            height: headerHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Image.network(widget.campaign.photoUrl, fit: BoxFit.cover),
                ),
                Container(color: Colors.black.withOpacity(0.2)),

                // Logo central
                Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                        begin: 0.0,
                        end: _isBlurred ? 10.0 : 0.0
                    ),
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut,
                    builder: (_, blurValue, child) {
                      return ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
                        child: child,
                      );
                    },
                    child: Container(
                      width: 100, height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.campaign.photoUrl),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 15, spreadRadius: 2)
                          ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. BOTONES DE NAVEGACIÓN SUPERIORES
          Positioned(
            top: statusBarHeight + 10,
            left: 16, right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCustomActionButton(
                  'assets/images/ic_back_arrow.png',
                      () => Navigator.pop(context),
                  hasBackground: true,
                ),
                _buildCustomActionButton(
                  'assets/images/ic_chat_bubble.png',
                      () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (_) => ChatListScreen(
                              campaignTitle: widget.campaign.title,
                              campaignImage: widget.campaign.photoUrl, // <--- AQUÍ PASAS LA FOTO
                            ))
                        );
                  },
                  hasBackground: false,
                ),
              ],
            ),
          ),

          // 3. TARJETA DESLIZANTE
          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: safeInitial,
            maxChildSize: safeMax,
            minChildSize: safeInitial,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, -5))
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(40.0)),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),

                          // Título
                          Text(
                            widget.campaign.title,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Marca
                          Row(
                            children: [
                              Text(
                                widget.campaign.brandName,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(width: 6),
                              Image.asset(
                                'assets/images/ic_verified.png',
                                width: 18,
                                height: 18,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // Chips de detalles
                          Row(
                            children: [
                              Expanded(
                                child: _buildDetailBox(
                                  label: 'Tipo',
                                  content: Text(
                                    widget.campaign.type,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildDetailBox(
                                  label: 'Plataformas',
                                  content: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset('assets/images/ic_tiktok.png', width: 18, height: 18),
                                      const SizedBox(width: 6),
                                      Image.asset('assets/images/ic_instagram.png', width: 18, height: 18),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildDetailBox(
                                  label: 'Fecha Límite',
                                  content: Text(
                                    widget.campaign.deadline,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // Barra de Progreso
                          _buildGradientProgressBar(),

                          const SizedBox(height: 32),

                          // Pestañas Centradas
                          _buildTabs(),

                          const SizedBox(height: 24),

                          // Contenido Dinámico
                          _selectedTab == 0 ? _buildInfoTab() : _buildResourcesTab(),

                          const SizedBox(height: 140),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // 4. BOTÓN FLOTANTE
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: _buildStickyBottomButton(),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildDetailBox({required String label, required Widget content}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.grey[500],
                fontSize: 11,
                fontWeight: FontWeight.w500
            ),
            maxLines: 1, overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          content,
        ],
      ),
    );
  }

  Widget _buildGradientProgressBar() {
    double progress = (widget.campaign.paidAmount / widget.campaign.totalBudget).clamp(0.0, 1.0);
    int percentage = (progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                      'Progreso de Campaña',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                  ),
                  const SizedBox(width: 6),
                  Image.asset('assets/images/ic_rayo.png', width: 16, height: 16),
                ],
              ),
              Text(
                  '$percentage%',
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF2E0B3F),
                        Color(0xFF5E17EB),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  'S/${widget.campaign.paidAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
              ),
              Text(
                  'de S/${widget.campaign.totalBudget.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500)
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomActionButton(String imagePath, VoidCallback onTap, {required bool hasBackground}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45, height: 45,
        padding: EdgeInsets.all(hasBackground ? 12 : 10),
        decoration: BoxDecoration(
          color: hasBackground ? Colors.white : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: hasBackground
              ? [const BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))]
              : null,
        ),
        child: Image.asset(
          imagePath,
          color: hasBackground ? Colors.black : Colors.white,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  // --- PESTAÑAS ---

  Widget _buildTabs() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDot(0),
            const SizedBox(width: 8),
            _buildDot(1),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTabButton('Información', 0),
            const SizedBox(width: 40),
            _buildTabButton('Recursos', 1),
          ],
        ),
      ],
    );
  }

  Widget _buildTabButton(String text, int index) {
    bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 17,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              color: isSelected ? Colors.black : Colors.grey[500],
            ),
          ),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            height: 3,
            width: isSelected ? 50 : 0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    bool isActive = _selectedTab == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[300],
        shape: BoxShape.circle,
      ),
    );
  }

  // --- CONTENIDO PESTAÑAS ---

  Widget _buildInfoTab() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Descripción', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      const SizedBox(height: 12),
      Text(widget.campaign.description, style: const TextStyle(color: Colors.black87, height: 1.5, fontSize: 14)),

      const SizedBox(height: 24),

      // TARJETAS OSCURAS (Pago y Recompensa)
      Row(
        children: [
          Expanded(
            child: _buildDarkStatCard(
              title: 'Pago Máximo',
              amount: 'S/${widget.campaign.totalBudget.toStringAsFixed(2)}',
              subtitle: '=100K vistas',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildDarkStatCard(
              title: 'Recompensa',
              amount: 'S/3.00',
              subtitle: '/1K vistas',
            ),
          ),
        ],
      ),

      const SizedBox(height: 24),

      const Text('Pautas de Contenido', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      const SizedBox(height: 16),

      // PAUTAS
      ...widget.campaign.requirements.map((req) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF8F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          const Icon(Icons.check_circle, size: 24, color: Colors.black),
          const SizedBox(width: 12),
          Expanded(child: Text(req, style: const TextStyle(fontWeight: FontWeight.w500))),
        ]),
      )),

      const SizedBox(height: 30),

      // GUIONES IA
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Guiones Inteligentes',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 6),
                  Text('Crea guiones impactantes con inteligencia artificial (IA)',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.2)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            FilledButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const GeneratingScriptScreen()));
              },
              icon: const Icon(Icons.auto_awesome, size: 16),
              label: const Text('Crear Guión'),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF222222),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            )
          ],
        ),
      ),
    ]);
  }

  Widget _buildDarkStatCard({required String title, required String amount, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black,
            Color(0xFF2C2C2C),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(amount, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
        ],
      ),
    );
  }

  // 2. RECURSOS
  Widget _buildResourcesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Archivos Adicionales', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),
        // BOTÓN QUE ABRE EL MODAL AL PRESIONAR
        _buildDarkResourceButton(
            icon: Icons.description_outlined,
            title: 'Instrucciones de Contenido',
            onTap: () {
              // LLAMAMOS AL MODAL AQUÍ
              _showInstructionsModal(context);
            }
        ),

        const SizedBox(height: 24),

        const Text('Redes Sociales', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 12),

        _buildSocialResourceButton(
            imagePath: 'assets/images/ic_instagram.png',
            title: 'Inklop.pe',
            subtitle: 'www.instagram.com/account/@ink...',
            onTap: () { }
        ),
        const SizedBox(height: 12),

        _buildSocialResourceButton(
            imagePath: 'assets/images/ic_tiktok.png',
            title: 'Inklop.pe',
            subtitle: 'www.tiktok.com/account/@ink...',
            onTap: () { }
        ),
      ],
    );
  }

  Widget _buildDarkResourceButton({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.black, Color(0xFF333333)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialResourceButton({
    required String imagePath,
    required String title,
    required String subtitle,
    required VoidCallback onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.black, Color(0xFF333333)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, width: 24, height: 24, color: Colors.white),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- BOTONES INFERIORES ---

  Widget _buildStickyBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 25, 24, 35),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFF2E0B3F),
            Colors.black,
          ],
          stops: [0.0, 0.7],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: SizedBox(
        height: 55,
        child: _isJoined
            ? _buildJoinedActions()
            : _buildJoinButton(),
      ),
    );
  }

  Widget _buildJoinButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() => _isJoined = true);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        child: const Text('Unirme a la Campaña'),
      ),
    );
  }

  Widget _buildJoinedActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            // --- AQUÍ HACEMOS LA CONEXIÓN ---
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MySubmissionsScreen(campaign: widget.campaign) // Pasamos la data
                  )
              );
            },
            // --------------------------------
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white, width: 1.0),
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Mis Envíos', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SendVideoScreen()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Enviar Video', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ),
        ),
      ],
    );
  }
}