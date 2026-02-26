import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/seat_model.dart';
import '../../routes/app_routes.dart';
import '../theme/theme_controller.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  ThemeController get t => Get.find<ThemeController>();

  Color _seatColor(SeatStatus status) => switch (status) {
    SeatStatus.available => const Color(0xFF2A2D3E),
    SeatStatus.selected  => const Color(0xFF00C853),
    SeatStatus.occupied  => const Color(0xFFE53935),
  };

  Color _seatBorder(SeatStatus status) => switch (status) {
    SeatStatus.available => const Color(0xFF4A4D5E),
    SeatStatus.selected  => const Color(0xFF69F0AE),
    SeatStatus.occupied  => const Color(0xFFEF9A9A),
  };

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: t.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: t.textPrimary, size: 18),
          onPressed: () => Get.back(),
        ),
        title: Column(
          children: [
            Text('Selección de Asientos',
                style: TextStyle(
                    color: t.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
            Text('Sala 1 · Función 7:00 PM',
                style: TextStyle(color: t.textSecondary, fontSize: 11)),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildScreen(),
          _buildLegend(),
          Expanded(child: _buildGrid()),
          _buildBottomBar(),
        ],
      ),
    ));
  }

  Widget _buildScreen() => Padding(
    padding: const EdgeInsets.fromLTRB(40, 8, 40, 0),
    child: Column(
      children: [
        Container(
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.transparent,
              Colors.white.withOpacity(0.8),
              Colors.transparent,
            ]),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(color: Colors.white.withOpacity(0.3), blurRadius: 20, spreadRadius: 3)
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text('P A N T A L L A',
            style: TextStyle(color: t.textSecondary, fontSize: 9, letterSpacing: 8)),
      ],
    ),
  );

  Widget _buildLegend() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(const Color(0xFF2A2D3E), const Color(0xFF4A4D5E), 'Disponible'),
        const SizedBox(width: 24),
        _legendItem(const Color(0xFF00C853), const Color(0xFF69F0AE), 'Seleccionado'),
        const SizedBox(width: 24),
        _legendItem(const Color(0xFFE53935), const Color(0xFFEF9A9A), 'Ocupado'),
      ],
    ),
  );

  Widget _legendItem(Color bg, Color border, String label) => Row(
    children: [
      Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: border, width: 1.5),
        ),
        child: const Center(
          child: Icon(Icons.chair_alt_rounded, color: Colors.white54, size: 10),
        ),
      ),
      const SizedBox(width: 6),
      Text(label, style: TextStyle(color: t.textSecondary, fontSize: 11)),
    ],
  );

  Widget _buildGrid() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 20),
            ...List.generate(10, (i) => Expanded(
              child: Center(
                child: Text('${i + 1}',
                    style: TextStyle(color: t.textSecondary, fontSize: 9)),
              ),
            )),
          ],
        ),
        const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (_, rowIndex) {
              final rowLabel = ['A', 'B', 'C', 'D', 'E'][rowIndex];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      child: Text(rowLabel,
                          style: TextStyle(color: t.textSecondary, fontSize: 9)),
                    ),
                    ...List.generate(10, (colIndex) {
                      final seat = controller.seats[rowIndex * 10 + colIndex];
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Obx(() => GestureDetector(
                            onTap: () => controller.toggleSeat(seat),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              height: 32,
                              decoration: BoxDecoration(
                                color: _seatColor(seat.status.value),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: _seatBorder(seat.status.value), width: 1),
                                boxShadow: seat.status.value == SeatStatus.selected
                                    ? [BoxShadow(
                                    color: const Color(0xFF00C853).withOpacity(0.4),
                                    blurRadius: 8,
                                    spreadRadius: 1)]
                                    : null,
                              ),
                              child: const Center(
                                child: Icon(Icons.chair_alt_rounded,
                                    color: Colors.white54, size: 14),
                              ),
                            ),
                          )),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  Widget _buildBottomBar() => Container(
    padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
    decoration: BoxDecoration(
      color: t.surface,
      border: Border(top: BorderSide(color: t.textSecondary.withOpacity(0.1))),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, -5))
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF00C853).withOpacity(0.4)),
                ),
                child: Text('${controller.selectedCount.value} / 4 asientos',
                    style: const TextStyle(
                        color: Color(0xFF00C853),
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              )),
              const SizedBox(height: 4),
              Obx(() => Text(
                '\$${controller.totalPrice.value.toStringAsFixed(0)} COP',
                style: TextStyle(
                    color: t.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5),
              )),
              Text('IVA incluido', style: TextStyle(color: t.textSecondary, fontSize: 10)),
            ],
          ),
        ),
        Obx(() => ElevatedButton(
          onPressed: controller.selectedCount.value == 0
              ? null
              : () => Get.toNamed(AppRoutes.checkout),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE53935),
            foregroundColor: Colors.white,
            disabledBackgroundColor: t.cardColor,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: controller.selectedCount.value == 0 ? 0 : 8,
            shadowColor: const Color(0xFFE53935).withOpacity(0.4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Continuar',
                  style: TextStyle(
                      color: controller.selectedCount.value == 0
                          ? t.textSecondary
                          : Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 6),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: controller.selectedCount.value == 0
                      ? t.textSecondary
                      : Colors.white),
            ],
          ),
        )),
      ],
    ),
  );
}
