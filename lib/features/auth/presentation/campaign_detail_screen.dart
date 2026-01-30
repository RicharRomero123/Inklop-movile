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
  int _selectedTab = 0;   // 0: Información, 1: Recursos
  bool _isJoined = false; // Estado para cambiar los botones inferiores

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. SCROLL PRINCIPAL (SLIVERS)
          CustomScrollView(
            slivers: [
              // HEADER PARALLAX
              SliverAppBar(
                expandedHeight: 220.0,
                floating: false,
                pinned: true,
                backgroundColor: const Color(0xFF2D0052),
                leading: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(Icons.chat_bubble_outline, size: 20, color: Colors.white),
                      onPressed: () {
                        // NAVEGAR AL CHAT
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatListScreen(campaignTitle: widget.campaign.title),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2D0052), Color(0xFF15002B)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Opacity(
                        opacity: 0.1,
                        child: Text(
                          widget.campaign.brandName.toUpperCase(),
                          style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w900, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // CONTENIDO DEL CUERPO
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -20),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      children: [
                        // LOGO FLOTANTE
                        Transform.translate(
                          offset: const Offset(0, -45),
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Color(widget.campaign.colorCode),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
                              ],
                            ),
                            child: Center(
                              child: Text(
                                widget.campaign.brandName[0],
                                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        // DATOS DE LA CAMPAÑA
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Text(widget.campaign.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text(widget.campaign.brandName, style: const TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified, size: 16, color: Colors.black),
                              ]),

                              const SizedBox(height: 24),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                _buildMiniDetail('Tipo', widget.campaign.type),
                                _buildMiniDetail('Plataformas', '', isIcon: true),
                                _buildMiniDetail('Fecha Límite', widget.campaign.deadline),
                              ]),

                              const SizedBox(height: 24),

                              // Barra de Progreso
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(color: const Color(0xFFFAFAFA), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                                child: Column(children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    const Text('Progreso de Campaña ⚡', style: TextStyle(fontWeight: FontWeight.w600)),
                                    Text('${(widget.campaign.paidAmount / widget.campaign.totalBudget * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ]),
                                  const SizedBox(height: 10),
                                  ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: widget.campaign.paidAmount / widget.campaign.totalBudget, minHeight: 8, backgroundColor: Colors.grey.shade200, color: const Color(0xFF5E17EB))),
                                  const SizedBox(height: 8),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    Text('S/${widget.campaign.paidAmount}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    Text('de S/${widget.campaign.totalBudget}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                  ]),
                                ]),
                              ),

                              const SizedBox(height: 24),

                              // TABS
                              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                _buildTabButton('Información', 0),
                                const SizedBox(width: 20),
                                _buildTabButton('Recursos', 1),
                              ]),
                              const SizedBox(height: 24),

                              // CONTENIDO DINÁMICO
                              _selectedTab == 0 ? _buildInfoTab() : _buildResourcesTab(),

                              const SizedBox(height: 120), // Espacio final
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 2. BOTÓN INFERIOR (Sticky)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.white, Colors.white, Colors.white.withOpacity(0.0)],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
              child: _buildBottomButton(),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS DE UI ---

  Widget _buildMiniDetail(String label, String value, {bool isIcon = false}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      const SizedBox(height: 4),
      if (isIcon) const Row(children: [Icon(Icons.tiktok, size: 18), SizedBox(width: 4), Icon(Icons.camera_alt, size: 18)])
      else Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
    ]);
  }

  Widget _buildTabButton(String text, int index) {
    bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(children: [
        Text(text, style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, color: isSelected ? Colors.black : Colors.grey)),
        const SizedBox(height: 6),
        Container(width: isSelected ? 40 : 0, height: 2, color: Colors.black),
      ]),
    );
  }

  // --- PESTAÑA INFORMACIÓN ---
  Widget _buildInfoTab() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Descripción', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      Text(widget.campaign.description, style: TextStyle(color: Colors.grey.shade700, height: 1.5, fontSize: 14)),
      const SizedBox(height: 24),
      Row(children: [
        Expanded(child: _buildDarkCard('Pago Máximo', widget.campaign.maxPay, '=100K vistas')),
        const SizedBox(width: 12),
        Expanded(child: _buildDarkCard('Recompensa', widget.campaign.reward, '/1K vistas')),
      ]),
      const SizedBox(height: 24),
      const Text('Pautas de Contenido', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 12),
      ...widget.campaign.requirements.map((req) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Icon(Icons.check_circle, size: 18, color: Colors.black),
          const SizedBox(width: 10),
          Expanded(child: Text(req, style: const TextStyle(fontSize: 13, height: 1.3))),
        ]),
      )),
      const SizedBox(height: 20),

      // CARD IA
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Guiones Inteligentes', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Crea guiones impactantes con IA', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            FilledButton.icon(
              onPressed: () {
                // NAVEGAR A IA
                Navigator.push(context, MaterialPageRoute(builder: (_) => const GeneratingScriptScreen()));
              },
              icon: const Icon(Icons.auto_awesome, size: 14, color: Colors.white),
              label: const Text('Crear Guión', style: TextStyle(fontSize: 12)),
              style: FilledButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildDarkCard(String label, String value, String sub) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 10)),
      ]),
    );
  }

  // --- PESTAÑA RECURSOS ---
  Widget _buildResourcesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Archivos Adicionales', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _showInstructionsDialog(context),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF333333), Color(0xFF1A1A1A)]),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              children: [
                Icon(Icons.description, color: Colors.white),
                SizedBox(width: 12),
                Expanded(child: Text('Instrucciones de Contenido', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text('Redes Sociales', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        ...widget.campaign.socialLinks.map((link) {
          bool isTikTok = link.contains('tiktok') || !link.contains('instagram');
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Icon(isTikTok ? Icons.tiktok : Icons.camera_alt, color: Colors.white, size: 20),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(widget.campaign.brandName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(link, style: const TextStyle(color: Colors.grey, fontSize: 12), overflow: TextOverflow.ellipsis),
                  ])),
                  const Icon(Icons.arrow_outward, color: Colors.white54, size: 18),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // --- POPUP INSTRUCCIONES ---
  void _showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          insetPadding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(children: [
                  Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Color(0xFF2D2D2D), shape: BoxShape.circle), child: const Icon(Icons.description, color: Colors.white, size: 24)),
                  const SizedBox(width: 12),
                  const Expanded(child: Text('Instrucciones de Contenido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                ]),
              ),
              const Divider(height: 1),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                    _InstructionSection(title: '1. Objetivo del contenido', content: 'Dar a conocer Inklop como la plataforma donde creadores pueden monetizar su contenido...'),
                    _InstructionSection(title: '2. Idea central', content: '"Inklop te conecta con marcas que pagan por tu contenido. Monetiza sin complicarte."'),
                    _InstructionSection(title: '3. Pilares', content: '1. Fácil de usar\n2. Oportunidades reales\n3. Rapidez y transparencia'),
                  ]),
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(children: [
                  Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.copy, size: 18, color: Colors.black), label: const Text('Copiar', style: TextStyle(color: Colors.black)), style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.black), padding: const EdgeInsets.symmetric(vertical: 12)))),
                  const SizedBox(width: 12),
                  Expanded(child: FilledButton(onPressed: () => Navigator.pop(context), style: FilledButton.styleFrom(backgroundColor: const Color(0xFF1A1A1A), padding: const EdgeInsets.symmetric(vertical: 12)), child: const Text('Entendido'))),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- BOTONES INFERIORES ---
  Widget _buildBottomButton() {
    if (!_isJoined) {
      return SizedBox(
        width: double.infinity, height: 56,
        child: FilledButton(
          onPressed: () {
            setState(() { _isJoined = true; });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('¡Te has unido a la campaña!')));
          },
          style: FilledButton.styleFrom(backgroundColor: Colors.white, side: const BorderSide(color: Colors.black, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          child: const Text('Unirme a la Campaña', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      );
    } else {
      return Row(children: [
        Expanded(child: SizedBox(height: 56, child: FilledButton(onPressed: () {}, style: FilledButton.styleFrom(backgroundColor: Colors.white, side: const BorderSide(color: Colors.black), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), child: const Text('Mis Envíos', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))))),
        const SizedBox(width: 16),
        // BOTÓN ENVIAR VIDEO CONECTADO
        Expanded(child: SizedBox(height: 56, child: FilledButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SendVideoScreen()));
            },
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF1A1A1A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), child: const Text('Enviar Video', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))))),
      ]);
    }
  }
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