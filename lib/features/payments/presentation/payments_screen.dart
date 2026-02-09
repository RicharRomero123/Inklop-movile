import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
// Ajusta tus importaciones
import 'package:inklop/features/home/presentation/notifications_screen.dart';
import 'wallet_screen.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- DIMENSIONES PARA EL DISEÑO FIJO ---

    // 1. Altura del fondo morado
    final double headerHeight = 115.0;

    // 2. Qué tan abajo empieza la tarjeta blanca (Aumentado para separarlo del AppBar)
    final double cardTopOffset = 130.0;

    // 3. Altura de la tarjeta blanca del gráfico
    final double cardHeight = 360.0;

    // 4. Espacio total que ocupa la parte FIJA (Header + Tarjeta)
    // Esto servirá para empujar la lista hacia abajo
    final double fixedHeaderArea = cardTopOffset + cardHeight + 20;

    return Scaffold(
      backgroundColor: Colors.white, // Fondo general blanco
      body: Stack(
        children: [
          // -------------------------------------------------------
          // CAPA 1: LA LISTA SCROLEABLE (Al fondo)
          // -------------------------------------------------------
          Positioned.fill(
            child: ListView(
              // El padding superior es CLAVE: empuja el primer item debajo del gráfico fijo
              padding: EdgeInsets.only(
                  top: fixedHeaderArea,
                  left: 24,
                  right: 24,
                  bottom: 30
              ),
              children: [
                const Text(
                    'Mis Ingresos',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)
                ),
                const SizedBox(height: 16),

                // ITEMS DE LA LISTA
                _buildIncomeItem('Comunidad Clipera de...', '01 Nov, 2025 - 5:24 hrs', '+ S/120.00', Colors.grey.shade800),
                _buildIncomeItem('Creadores LaundryHeap', '30 Set, 2025 - 14:56 hrs', '+ S/70.00', Colors.blue),
                _buildIncomeItem('Creadores Inklop', '20 Set, 2025 - 12:24 hrs', '+ S/500.00', const Color(0xFFFF4081)),
                _buildIncomeItem('Creadores Inklop', '20 Set, 2025 - 12:12 hrs', '+ S/500.00', const Color(0xFFFF4081)),
                _buildIncomeItem('Creadores Inklop', '15 Set, 2025 - 10:00 hrs', '+ S/200.00', const Color(0xFFFF4081)),
                _buildIncomeItem('Creadores Inklop', '10 Set, 2025 - 09:30 hrs', '+ S/150.00', const Color(0xFFFF4081)),
              ],
            ),
          ),

          // -------------------------------------------------------
          // CAPA 2: CABECERA ESTÁTICA (Frente - No se mueve)
          // -------------------------------------------------------
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: fixedHeaderArea, // Altura exacta para contener el morado + tarjeta
            child: Stack(
              clipBehavior: Clip.none, // Permite sombras fuera de los límites
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
                        const Text(
                            'Mis Pagos',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            )
                        ),

                        // --- ICONO DE NOTIFICACIÓN (Assets/images) ---
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) => const NotificationsScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  const begin = Offset(0.0, -1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeOutQuart;
                                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                                  return SlideTransition(position: animation.drive(tween), child: child);
                                },
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/ic_notification_home.png', // RUTA CORREGIDA
                            width: 28,
                            height: 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // B. TARJETA FLOTANTE (GRÁFICA)
                Positioned(
                  top: cardTopOffset, // Bajado para separar del título
                  left: 20,
                  right: 20,
                  height: cardHeight,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 10)
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header de la tarjeta
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                                'Ganancias Totales',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87)
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletScreen()));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30)),
                                child: const Row(
                                  children: [
                                    Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 16),
                                    SizedBox(width: 8),
                                    Text('Mi Billetera', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // MONTO GRANDE Y BOLD
                        const Text(
                            '\$2,058.00',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1.0,
                                color: Colors.black
                            )
                        ),
                        const SizedBox(height: 12),

                        // Dots
                        Row(
                          children: [
                            _buildStatusDot(const Color(0xFF00C853), 'Pagado: 0.00'),
                            const SizedBox(width: 16),
                            _buildStatusDot(const Color(0xFFFF5252), 'En Proceso: 0.00'),
                          ],
                        ),

                        const Spacer(),

                        // Gráfica
                        SizedBox(
                          height: 160,
                          child: LineChart(_mainData()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- MISMOS MÉTODOS AUXILIARES (Sin cambios en lógica interna) ---

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
            interval: 2,
            getTitlesWidget: (value, meta) {
              const style = TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500);
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
      minX: 0, maxX: 8, minY: 0, maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 2), FlSpot(1, 3), FlSpot(2, 2.5), FlSpot(3, 3.8),
            FlSpot(4, 2.8), FlSpot(5, 4.2), FlSpot(6, 3.0), FlSpot(7, 5.0), FlSpot(8, 4.0),
          ],
          isCurved: true,
          curveSmoothness: 0.35,
          color: Colors.black,
          barWidth: 2.5,
          isStrokeCapRound: true,
          dotData: FlDotData(
              show: true,
              checkToShowDot: (spot, barData) => spot.x == 5,
              getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                  radius: 6, color: Colors.black, strokeWidth: 3, strokeColor: Colors.white
              )
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [Colors.grey.withOpacity(0.2), Colors.grey.withOpacity(0.0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: const Color(0xFF1A1A1A),
            tooltipRoundedRadius: 8,
            tooltipPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                return LineTooltipItem(
                    '\$900',
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)
                );
              }).toList();
            }
        ),
      ),
    );
  }

  Widget _buildStatusDot(Color color, String text) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildIncomeItem(String title, String date, String amount, Color iconColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                    image: NetworkImage('https://i.pravatar.cc/150?img=12'), fit: BoxFit.cover
                )
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(date, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
              ],
            ),
          ),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Colors.black)),
        ],
      ),
    );
  }
}