import 'package:flutter/material.dart';
import 'package:inklop/features/home/domain/campaign_model.dart';
import 'package:inklop/features/home/presentation/ai_script_screens.dart';
import 'package:inklop/features/home/presentation/chat_list_screen.dart';
import 'package:inklop/features/home/presentation/send_video_screen.dart';

class CampaignDetailScreen extends StatefulWidget {
  final CampaignModel campaign;

  const CampaignDetailScreen({super.key, required this.campaign});

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  int _selectedTab = 0; // 0: Información, 1: Recursos
  bool _isJoined = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // 1. HEADER DINÁMICO (Contiene Portada y Logo Sticky)
              SliverPersistentHeader(
                pinned: true,
                delegate: _CampaignHeaderDelegate(
                  campaign: widget.campaign,
                  expandedHeight: 220,
                ),
              ),

              // 2. CUERPO DE LA CAMPAÑA
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 50), // Espacio para que el título no quede bajo el logo

                      // Título y Marca
                      Text(
                        widget.campaign.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.campaign.brandName,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, size: 18, color: Colors.blue),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Fila de Detalles Rápidos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildMiniDetail('Tipo', widget.campaign.type),
                          _buildMiniDetail('Plataformas', '', isIcon: true),
                          _buildMiniDetail('Fecha Límite', widget.campaign.deadline),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // Barra de Progreso
                      _buildProgressBar(),

                      const SizedBox(height: 40),

                      // Selector de Pestañas (Tabs)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTabButton('Información', 0),
                          const SizedBox(width: 40),
                          _buildTabButton('Recursos', 1),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Contenido Dinámico según Tab
                      _selectedTab == 0 ? _buildInfoTab() : _buildResourcesTab(),

                      const SizedBox(height: 140), // Margen inferior para el botón
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 3. BOTÓN INFERIOR STICKY
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildStickyBottomButton(),
          ),
        ],
      ),
    );
  }

  // --- COMPONENTES DE UI ---

  Widget _buildProgressBar() {
    double progress = (widget.campaign.paidAmount / widget.campaign.totalBudget).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Progreso de Campaña ⚡', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text('${(progress * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF5E17EB))),
        ]),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 10,
            backgroundColor: Colors.grey.shade200,
            color: const Color(0xFF5E17EB),
          ),
        ),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('S/${widget.campaign.paidAmount}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Text('meta: S/${widget.campaign.totalBudget}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
        ]),
      ]),
    );
  }

  Widget _buildTabButton(String text, int index) {
    bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(children: [
        Text(text, style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, color: isSelected ? Colors.black : Colors.grey)),
        const SizedBox(height: 8),
        AnimatedContainer(duration: const Duration(milliseconds: 200), width: isSelected ? 30 : 0, height: 3, color: const Color(0xFF5E17EB)),
      ]),
    );
  }

  Widget _buildMiniDetail(String label, String value, {bool isIcon = false}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
      const SizedBox(height: 6),
      if (isIcon) const Row(children: [Icon(Icons.tiktok, size: 18), SizedBox(width: 8), Icon(Icons.camera_alt, size: 18)])
      else Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    ]);
  }

  // --- CONTENIDO DE PESTAÑAS ---

  Widget _buildInfoTab() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Descripción', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 12),
      Text(widget.campaign.description, style: TextStyle(color: Colors.grey.shade700, height: 1.6, fontSize: 15)),
      const SizedBox(height: 24),
      Row(children: [
        Expanded(child: _buildDarkCard('Pago Máximo', widget.campaign.maxPay, '≈ 100K vistas')),
        const SizedBox(width: 12),
        Expanded(child: _buildDarkCard('Recompensa', widget.campaign.reward, '/ 1K vistas')),
      ]),
      const SizedBox(height: 32),
      const Text('Pautas de Contenido', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 16),
      ...widget.campaign.requirements.map((req) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.check_circle_outline, size: 20, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(child: Text(req, style: const TextStyle(fontSize: 14, height: 1.4))),
        ]),
      )),
      const SizedBox(height: 20),
      _buildAIButton(),
    ]);
  }

  Widget _buildResourcesTab() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Archivos Adicionales', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 16),
      _buildResourceItem(Icons.picture_as_pdf, 'Instrucciones de Contenido', '2.4 MB'),
      const SizedBox(height: 32),
      const Text('Redes Sociales', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 16),
      ...widget.campaign.socialLinks.map((link) => _buildSocialItem(link)),
    ]);
  }

  // --- COMPONENTES ATÓMICOS ---

  Widget _buildAIButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF3F3F3), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black12)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Guiones Inteligentes', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('Crea guiones impactantes con IA', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ]),
        FilledButton.icon(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GeneratingScriptScreen())),
          icon: const Icon(Icons.auto_awesome, size: 14),
          label: const Text('Crear Guión', style: TextStyle(fontSize: 12)),
          style: FilledButton.styleFrom(backgroundColor: Colors.black),
        ),
      ]),
    );
  }

  Widget _buildDarkCard(String label, String value, String sub) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 10)),
      ]),
    );
  }

  Widget _buildResourceItem(IconData icon, String title, String size) {
    return GestureDetector(
      onTap: () => _showInstructionsDialog(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Icon(icon, color: Colors.black87),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ]),
      ),
    );
  }

  Widget _buildSocialItem(String link) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(30)),
      child: Row(children: [
        Icon(link.contains('tiktok') ? Icons.tiktok : Icons.facebook, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Expanded(child: Text(link, style: const TextStyle(color: Colors.white, fontSize: 13), overflow: TextOverflow.ellipsis)),
        const Icon(Icons.arrow_outward, color: Colors.white54, size: 18),
      ]),
    );
  }

  Widget _buildStickyBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 34),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.white, Colors.white.withOpacity(0.9), Colors.white.withOpacity(0.0)],
          stops: const [0.0, 0.8, 1.0],
        ),
      ),
      child: !_isJoined
          ? SizedBox(
        width: double.infinity, height: 58,
        child: FilledButton(
          onPressed: () => setState(() => _isJoined = true),
          style: FilledButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          child: const Text('Unirme a la Campaña', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      )
          : Row(children: [
        Expanded(child: SizedBox(height: 58, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: const BorderSide(width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Mis Envíos', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))))),
        const SizedBox(width: 16),
        Expanded(child: SizedBox(height: 58, child: FilledButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SendVideoScreen())), style: FilledButton.styleFrom(backgroundColor: const Color(0xFF1A1A1A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Enviar Video', style: TextStyle(fontWeight: FontWeight.bold))))),
      ]),
    );
  }

  void _showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(children: [
                  const Icon(Icons.description, size: 24),
                  const SizedBox(width: 12),
                  const Expanded(child: Text('Instrucciones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                ]),
              ),
              const Divider(height: 1),
              const Padding(
                padding: EdgeInsets.all(24),
                child: Text('Aquí van las instrucciones detalladas para tu contenido en Inklop.'),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(backgroundColor: Colors.black, minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Entendido'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// --- DELEGATE PARA EL HEADER ANIMADO (LOGO STICKY) ---
class _CampaignHeaderDelegate extends SliverPersistentHeaderDelegate {
  final CampaignModel campaign;
  final double expandedHeight;

  _CampaignHeaderDelegate({required this.campaign, required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double progress = shrinkOffset / (maxExtent - minExtent);
    final double logoSize = (1 - progress).clamp(0.6, 1.0) * 100;

    // El logo baja pero se queda sticky a 70px del top cuando colapsa
    final double logoYPosition = (expandedHeight - 50) - shrinkOffset;
    final double finalLogoY = logoYPosition > 70 ? logoYPosition : 70;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        // Fondo con Gradiente
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2D0052), Color(0xFF15002B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Opacity(
              opacity: (1 - progress).clamp(0, 0.15),
              child: Text(campaign.brandName.toUpperCase(), style: const TextStyle(fontSize: 70, fontWeight: FontWeight.w900, color: Colors.white)),
            ),
          ),
        ),

        // LOGO STICKY
        Positioned(
          top: finalLogoY,
          left: (MediaQuery.of(context).size.width / 2) - (logoSize / 2),
          child: Container(
            width: logoSize,
            height: logoSize,
            decoration: BoxDecoration(
              color: Color(campaign.colorCode),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 5),
              boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))],
            ),
            child: Center(
              child: Text(
                campaign.brandName[0].toUpperCase(),
                style: TextStyle(fontSize: logoSize * 0.45, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),

        // Botones de Navegación
        Positioned(
          top: 45,
          left: 16,
          child: IconButton(
            icon: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          top: 45,
          right: 16,
          child: IconButton(
            icon: const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.chat_bubble_outline, size: 20, color: Colors.white)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ChatListScreen(campaignTitle: campaign.title)));
            },
          ),
        ),
      ],
    );
  }

  @override double get maxExtent => expandedHeight;
  @override double get minExtent => 130;
  @override bool shouldRebuild(covariant _CampaignHeaderDelegate oldDelegate) => true;
}

class _InstructionSection extends StatelessWidget {
  final String title;
  final String content;
  const _InstructionSection({required this.title, required this.content});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(height: 4), Text(content, style: TextStyle(color: Colors.grey.shade800, fontSize: 13, height: 1.4))]));
  }
}