import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        title: const Text('Confirmar Compra'),
        backgroundColor: const Color(0xFF16213E),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🔑 Obx aquí: solo el timer card se reconstruye cada segundo
            Obx(() => _buildTimerCard()),
            const SizedBox(height: 20),
            _buildSummaryCard(),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: controller.confirmPayment,
              icon: const Icon(Icons.payment_rounded),
              label: const Text(
                'Confirmar y Pagar',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerCard() => AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    padding:
    const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
    decoration: BoxDecoration(
      color: controller.isUrgent
          ? Colors.red.shade900
          : const Color(0xFF16213E),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: controller.isUrgent ? Colors.red : Colors.blueGrey,
        width: 1.5,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.timer_outlined,
            color: controller.isUrgent
                ? Colors.red.shade300
                : Colors.orange,
            size: 30),
        const SizedBox(width: 14),
        Column(
          children: [
            const Text('Tiempo para confirmar',
                style:
                TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 4),
            Text(
              controller.formattedTime,
              style: TextStyle(
                color: controller.isUrgent
                    ? Colors.red.shade300
                    : Colors.white,
                fontSize: 46,
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildSummaryCard() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF16213E),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.blueGrey),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Resumen de Compra',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const Divider(color: Colors.blueGrey, height: 20),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.event_seat, color: Colors.white54, size: 18),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'Boletas: ${controller.selectedSeatIds.join(', ')}',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
