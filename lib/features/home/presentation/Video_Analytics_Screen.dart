import 'package:flutter/material.dart';
import 'package:inklop/features/payments/presentation/wallet_screen.dart';
import 'dart:math'; // Para la animación del carrusel

// --- CORRECCIÓN DEL IMPORT ---
// Usamos un import relativo. Asegúrate de que el archivo 'wallet_screen.dart'


class VideoAnalyticsScreen extends StatefulWidget {
  const VideoAnalyticsScreen({super.key});

  @override
  State<VideoAnalyticsScreen> createState() => _VideoAnalyticsScreenState();
}

enum PaymentStatus { initial, processing, completed }

class _VideoAnalyticsScreenState extends State<VideoAnalyticsScreen> {
  late PageController _pageController;
  int _currentPage = 1;
  PaymentStatus _paymentStatus = PaymentStatus.initial;

  @override
  void initState() {
    super.initState();
    // viewportFraction 0.60 para que se vean los videos laterales como en tu diseño
    _pageController = PageController(initialPage: _currentPage, viewportFraction: 0.60);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // --- LÓGICA DE COBRO ---
  void _startPaymentFlow() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _PaymentDetailSheet(
        onConfirm: () {
          Navigator.pop(context);
          _processPayment();
        },
      ),
    );
  }

  void _processPayment() async {
    setState(() => _paymentStatus = PaymentStatus.processing);
    await Future.delayed(const Duration(seconds: 2)); // Simula carga
    if (mounted) {
      setState(() => _paymentStatus = PaymentStatus.completed);
    }
  }

  void _goToWallet() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen()));
  }

  @override
  Widget build(BuildContext context) {
    // Usamos LayoutBuilder para adaptar alturas sutilmente
    final size = MediaQuery.of(context).size;
    final bool isSmallScreen = size.height < 700;

    return Scaffold(
      backgroundColor: Colors.white, // Fondo BLANCO PURO
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Analíticas del video', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF5DD669), // Verde "Aceptado"
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Aceptado', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          // 1. CARRUSEL DE VIDEOS
          SizedBox(
            height: isSmallScreen ? 290 : 340, // Altura ajustada
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: 3,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                    } else {
                      value = index == _currentPage ? 1.0 : 0.7;
                    }
                    final double curve = Curves.easeOut.transform(value);

                    return Center(
                      child: SizedBox(
                        height: curve * (isSmallScreen ? 290 : 340),
                        width: curve * (isSmallScreen ? 210 : 230),
                        child: child,
                      ),
                    );
                  },
                  child: _buildSkeletonVideoCard(),
                );
              },
            ),
          ),

          // 2. BOTÓN LINK VIDEO
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Link del Video', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                SizedBox(width: 6),
                Icon(Icons.open_in_new, color: Colors.white, size: 14)
              ],
            ),
          ),

          // 3. INFORMACIÓN
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Usuario
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFEEEEEE),
                        child: Icon(Icons.person, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text('Cesar Mesia', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(width: 4),
                              Icon(Icons.music_note, size: 16)
                            ],
                          ),
                          Text('Enviado el 14 Julio de 2025', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Descripción
                  const Text(
                    '¿Una semana súper full? Te entendemos💆‍♂️💨 Ponte los audífonos, olvídate del rush y date un beauty break en nuestra flagship ✨Testea, huele y enamórate de TODO... #aruma #flagship',
                    style: TextStyle(height: 1.4, fontSize: 13, color: Colors.black87),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 20),

                  // Estadísticas
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatItem(icon: Icons.remove_red_eye, value: '7.0 K'),
                      _StatItem(icon: Icons.favorite, value: '846 k'),
                      _StatItem(icon: Icons.comment, value: '120'),
                      _StatItem(icon: Icons.share, value: '3.8 k'),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Cajas de Datos
                  Row(
                    children: [
                      Expanded(child: _buildDataBox('Visualizaciones', '7,025', Icons.remove_red_eye)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildDataBox('Pago Acumulado', 'S/21.00', Icons.account_balance_wallet)),
                    ],
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),

      // 4. BOTONES FLOTANTES
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildBottomActions(),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildSkeletonVideoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
          ]
      ),
      child: Center(
        child: Icon(Icons.play_arrow_rounded, size: 50, color: Colors.grey[300]),
      ),
    );
  }

  Widget _buildDataBox(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: Colors.black87),
              const SizedBox(width: 6),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          )
        ],
      ),
    );
  }

  // --- LÓGICA DE BOTONES (Con el icono ic_wallet_pay.png) ---
  Widget _buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: _paymentStatus == PaymentStatus.processing
          ? Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(30)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.black54)),
            SizedBox(width: 12),
            Text('Procesando Cobro', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15)),
          ],
        ),
      )
          : _paymentStatus == PaymentStatus.completed
          ? Row(
        children: [
          // Botón Verde "Cobrado"
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(color: const Color(0xFF5DD669), borderRadius: BorderRadius.circular(30)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text('Cobrado', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Botón Negro "Mi Wallet" CON TU ICONO PNG
          Expanded(
            child: SizedBox(
              height: 56,
              child: FilledButton.icon(
                onPressed: _goToWallet,
                // CAMBIO: USAMOS TU ASSET
                icon: Image.asset(
                    'assets/images/ic_wallet_pay.png',
                    width: 22,
                    height: 22,
                    color: Colors.white // Pintamos de blanco para que se vea en fondo negro
                ),
                label: const Text('Mi Wallet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ),
        ],
      )
          : SizedBox(
        width: double.infinity,
        height: 56,
        child: FilledButton.icon(
          onPressed: _startPaymentFlow,
          icon: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 22),
          label: const Text('Cobrar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF1E1E1E), // Negro elegante
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  const _StatItem({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Icon(icon, size: 18, color: Colors.black87),
          const SizedBox(width: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))
        ]
    );
  }
}

// --- SHEET DE DETALLE DE PAGO ---
class _PaymentDetailSheet extends StatelessWidget {
  final VoidCallback onConfirm;
  const _PaymentDetailSheet({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(child: Text('Detalle de Cobro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 24),

          // Barra Presupuesto
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Presupuesto Restante', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            Text('s/450.23', style: TextStyle(fontSize: 13)),
          ]),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(value: 0.3, minHeight: 6, color: Colors.purple, backgroundColor: Color(0xFFEEEEEE)),
          ),
          const SizedBox(height: 24),

          // Tabla de valores
          _buildRow('Total acumulado', 'S/21.00'),
          _buildRow('Retiro Total', 'S/21.00'),
          _buildRow('Comisión Inklop (30%)', '- S/6.30', isRed: true),
          const Divider(height: 30),
          _buildRow('Total a recibir', 'S/14.70', isBold: true),

          const SizedBox(height: 20),

          // Advertencia
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFFBEAEA), borderRadius: BorderRadius.circular(12)),
            child: const Row(
              children: [
                Icon(Icons.error_outline, color: Colors.black54, size: 20),
                SizedBox(width: 12),
                Expanded(child: Text('Advertencia\nUna vez cobradas las ganancias del video, ya no seguirá acumulando ganancias futuras', style: TextStyle(fontSize: 11, color: Colors.black87, height: 1.3))),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Botones del Modal
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: const Text('Prefiero esperar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: onConfirm,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF240b36),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Cobrar S/14.70', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isRed = false, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: isRed ? Colors.red : Colors.black
          )),
        ],
      ),
    );
  }
}