import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/seat_model.dart';
import '../../routes/app_routes.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Color _seatColor(SeatStatus status) => switch (status) {
    SeatStatus.available => Colors.grey.shade600,
    SeatStatus.selected  => Colors.green,
    SeatStatus.occupied  => Colors.red.shade400,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text('🎬 Cinema Booking'),
        backgroundColor: const Color(0xFF16213E),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildScreen(),
          _buildLegend(),
          Expanded(child: _buildGrid()),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildScreen() => Padding(
    padding: const EdgeInsets.fromLTRB(32, 16, 32, 4),
    child: Column(
      children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.4),
                blurRadius: 12,
                spreadRadius: 2,
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text('P A N T A L L A',
            style: TextStyle(
                color: Colors.white38, fontSize: 10, letterSpacing: 6)),
      ],
    ),
  );

  Widget _buildLegend() => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem(Colors.grey.shade600, 'Disponible'),
        const SizedBox(width: 20),
        _legendItem(Colors.green, 'Seleccionado'),
        const SizedBox(width: 20),
        _legendItem(Colors.red.shade400, 'Ocupado'),
      ],
    ),
  );

  Widget _legendItem(Color c, String label) => Row(
    children: [
      Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
              color: c, borderRadius: BorderRadius.circular(3))),
      const SizedBox(width: 4),
      Text(label,
          style: const TextStyle(color: Colors.white54, fontSize: 11)),
    ],
  );

  Widget _buildGrid() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: GridView.builder(
      itemCount: controller.seats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 10,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (_, index) {
        final seat = controller.seats[index];
        return Obx(() => GestureDetector(
          onTap: () => controller.toggleSeat(seat),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: _seatColor(seat.status.value),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                seat.id,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ));
      },
    ),
  );

  Widget _buildBottomBar() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      color: Color(0xFF16213E),
      boxShadow: [
        BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, -3))
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => Text(
                '${controller.selectedCount.value} asiento(s)',
                style: const TextStyle(
                    color: Colors.white54, fontSize: 12),
              )),
              Obx(() => Text(
                '\$${controller.totalPrice.value.toStringAsFixed(0)} COP',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ],
          ),
        ),
        Obx(() => ElevatedButton(
          onPressed: controller.selectedCount.value == 0
              ? null
              : () => Get.toNamed(AppRoutes.checkout),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey.shade700,
            padding: const EdgeInsets.symmetric(
                horizontal: 28, vertical: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Continuar →',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
        )),
      ],
    ),
  );
}
