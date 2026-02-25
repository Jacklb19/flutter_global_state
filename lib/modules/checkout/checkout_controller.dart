import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../home/home_controller.dart';

class CheckoutController extends GetxController {
  static const int _totalSeconds = 180;

  final RxInt remainingSeconds = _totalSeconds.obs;
  Timer? _timer;
  bool _completed = false;

  late final HomeController _homeController;

  @override
  void onInit() {
    super.onInit();
    _homeController = Get.find<HomeController>();
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    if (!_completed) _homeController.releaseSelectedSeats();
    super.onClose();
  }

  String get formattedTime {
    final m = (remainingSeconds.value ~/ 60).toString().padLeft(2, '0');
    final s = (remainingSeconds.value % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  bool get isUrgent => remainingSeconds.value <= 30;

  List<String> get selectedSeatIds =>
      _homeController.selectedSeats.map((s) => s.id).toList();

  double get totalPrice => _homeController.totalPrice.value;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remainingSeconds.value <= 1) {
        remainingSeconds.value = 0;
        _onTimeout();
      } else {
        remainingSeconds.value--;  // ✅ Fix crítico aquí
      }
    });
  }

  void _onTimeout() {
    _timer?.cancel();
    _completed = true;
    _homeController.releaseSelectedSeats();
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text('⏰ Tiempo expirado',
            style: TextStyle(color: Colors.white)),
        content: const Text(
          'Tu reserva caducó. Los asientos han sido liberados.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.offAllNamed(AppRoutes.home),
            child: const Text('Aceptar',
                style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void confirmPayment() {
    _timer?.cancel();
    _completed = true;
    final seats = selectedSeatIds.join(', ');
    final price = totalPrice;
    _homeController.markSelectedAsOccupied();
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text('🎉 ¡Pago exitoso!',
            style: TextStyle(color: Colors.white)),
        content: Text(
          'Asientos: $seats\nTotal: \$${price.toStringAsFixed(0)} COP\n\n¡Disfruta la película!',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.offAllNamed(AppRoutes.home),
            child: const Text('¡Listo!',
                style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
