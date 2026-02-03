import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
// Asegúrate de que esta ruta sea correcta según tu estructura de carpetas
import 'package:inklop/features/home/presentation/notifications_screen.dart';
import 'wallet_screen.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Definimos alturas fijas para calcular el diseño estático
    final double headerHeight = 220.0; // Altura del fondo morado
    final double cardHeight = 340.0;   // Altura de la tarjeta blanca con gráfica
    final double cardTopOffset = 100.0; // Dónde empieza la tarjeta blanca
    final double totalFixedHeaderHeight = cardTopOffset + cardHeight + 20;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // -------------------------------------------------------
          // 1. SECCIÓN FIJA (HEADER + GRÁFICA)
          // -------------------------------------------------------
          SizedBox(
            height: totalFixedHeaderHeight,
            child: Stack(
              children: [
                // A. FONDO MORADO
                Positioned(
                  top: 0, left: 0, right: 0,
                  height: headerHeight,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2D0052), Color(0xFF15002B)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Mis Pagos', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),

                        // --- BOTÓN DE NOTIFICACIONES CON ANIMACIÓN DE CAÍDA ---
                        IconButton(
                          icon: const Icon(Icons.notifications_none, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const NotificationsScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  // Animación: Deslizar desde arriba (Offset 0, -1) hacia el centro
                                  const begin = Offset(0.0, -1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeOutQuart; // Rebote suave al final

                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 500),
                              ),
                            );
                          },
                        ),
                        // -----------------------------------------
                      ],
                    ),
                  ),
                ),

                // B. TARJETA FLOTANTE (GRÁFICA)
                Positioned(
                  top: cardTopOffset,
                  left: 20,
                  right: 20,
                  height: cardHeight,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 5))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Encabezado Tarjeta
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Ganancias Totales', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen()));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                                child: const Row(
                                  children: [
                                    Icon(Icons.wallet, color: Colors.white, size: 16),
                                    SizedBox(width: 6),
                                    Text('Mi Billetera', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('S/ 2,058.00', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildStatusDot(Colors.green, 'Pagado: 0.00'),
                            const SizedBox(width: 16),
                            _buildStatusDot(Colors.orange, 'En Proceso: 0.00'),
                          ],
                        ),

                        const Spacer(),

                        // Gráfica
                        SizedBox(
                          height: 150,
                          child: LineChart(_mainData()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // -------------------------------------------------------
          // 2. SECCIÓN SCROLLABLE (LISTA DE TRANSACCIONES)
          // -------------------------------------------------------
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              children: [
                const Text('Mis Ingresos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                // ITEMS DE LA LISTA
                _buildIncomeItem('Comunidad Clipera', '01 Nov, 2025 - 5:24 hrs', '+ S/120.00', Colors.grey),
                _buildIncomeItem('Creadores LaundryHeap', '30 Set, 2025 - 14:56 hrs', '+ S/70.00', Colors.blue),
                _buildIncomeItem('Creadores Inklop', '20 Set, 2025 - 12:24 hrs', '+ S/500.00', const Color(0xFFFF4081)),
                _buildIncomeItem('Creadores Inklop', '20 Set, 2025 - 12:12 hrs', '+ S/500.00', const Color(0xFFFF4081)),
                _buildIncomeItem('Creadores Inklop', '15 Set, 2025 - 10:00 hrs', '+ S/200.00', const Color(0xFFFF4081)),
                _buildIncomeItem('Creadores Inklop', '10 Set, 2025 - 09:30 hrs', '+ S/150.00', const Color(0xFFFF4081)),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- MÉTODOS DE CONFIGURACIÓN DE GRÁFICA Y WIDGETS ---

  LineChartData _mainData() {
    return LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(color: Colors.grey, fontSize: 12);
                String text;
                switch (value.toInt()) {
                  case 0: text = 'Jan'; break;
                  case 2: text = 'Feb'; break;
                  case 4: text = 'Mar'; break;
                  case 6: text = 'Apr'; break;
                  case 8: text = 'May'; break;
                  default: return Container();
                }
                return SideTitleWidget(axisSide: meta.axisSide, child: Text(text, style: style));
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0, maxX: 10, minY: 0, maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: const [FlSpot(0, 3), FlSpot(2, 2), FlSpot(4, 5), FlSpot(6, 3.1), FlSpot(8, 4), FlSpot(10, 3)],
            isCurved: true,
            color: Colors.black,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.1), Colors.white.withOpacity(0.0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.black,
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  return LineTooltipItem(
                      '\$900',
                      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)
                  );
                }).toList();
              }
          ),
        )
    );
  }

  Widget _buildStatusDot(Color color, String text) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildIncomeItem(String title, String date, String amount, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.person, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}