import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/theme_controller.dart';
import 'checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  ThemeController get t => Get.find<ThemeController>();

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
        title: Text('Confirmar Compra',
            style: TextStyle(color: t.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() => _buildTimerCard()),
            const SizedBox(height: 16),
            _buildMovieCard(),
            const SizedBox(height: 16),
            _buildTicketsCard(),
            const SizedBox(height: 16),
            _buildPaymentCard(),
            const SizedBox(height: 16),
            _buildPriceBreakdown(),
            const SizedBox(height: 24),
            _buildPayButton(),
            const SizedBox(height: 12),
            _buildSecurityNote(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ));
  }

  Widget _buildTimerCard() => AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      color: controller.isUrgent ? const Color(0xFF7F0000) : t.surface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: controller.isUrgent ? Colors.red.shade400 : Colors.orange.withOpacity(0.4),
        width: 1,
      ),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: controller.isUrgent
                ? Colors.red.withOpacity(0.2)
                : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.timer_outlined,
              color: controller.isUrgent ? Colors.red.shade300 : Colors.orange, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.isUrgent ? '¡Apresúrate! Tu reserva vence pronto' : 'Reserva temporal activa',
                style: TextStyle(
                  color: controller.isUrgent ? Colors.red.shade200 : t.textSecondary,
                  fontSize: 12,
                ),
              ),
              Text('Los asientos se liberan en ${controller.formattedTime}',
                  style: TextStyle(color: t.textSecondary, fontSize: 10)),
            ],
          ),
        ),
        Text(
          controller.formattedTime,
          style: TextStyle(
            color: controller.isUrgent ? Colors.red.shade300 : Colors.orange,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    ),
  );

  Widget _buildMovieCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: t.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: t.textSecondary.withOpacity(0.1)),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 60,
            height: 80,
            color: t.cardColor,
            child: const Icon(Icons.movie_filter_rounded, color: Colors.red, size: 30),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Función seleccionada',
                  style: TextStyle(color: t.textSecondary, fontSize: 11)),
              const SizedBox(height: 4),
              Text('CineApp Cinema',
                  style: TextStyle(
                      color: t.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _infoRow(Icons.calendar_today_outlined, 'Hoy, 25 Feb 2026'),
              const SizedBox(height: 4),
              _infoRow(Icons.access_time_rounded, '7:00 PM · Sala 1'),
              const SizedBox(height: 4),
              _infoRow(Icons.location_on_outlined, 'CineApp · Piso 3'),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _infoRow(IconData icon, String text) => Row(
    children: [
      Icon(icon, color: t.textSecondary, size: 13),
      const SizedBox(width: 5),
      Text(text, style: TextStyle(color: t.textSecondary, fontSize: 12)),
    ],
  );

  Widget _buildTicketsCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: t.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: t.textSecondary.withOpacity(0.1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.confirmation_number_outlined, color: Colors.red, size: 18),
            const SizedBox(width: 8),
            Text('Tus Boletas',
                style: TextStyle(
                    color: t.textPrimary, fontSize: 15, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.selectedSeatIds
              .map((id) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: t.cardColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.chair_alt_rounded, color: Colors.red, size: 14),
                const SizedBox(width: 6),
                Text('Asiento $id',
                    style: TextStyle(
                        color: t.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ))
              .toList(),
        ),
      ],
    ),
  );

  Widget _buildPaymentCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: t.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: t.textSecondary.withOpacity(0.1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.credit_card_rounded, color: Colors.red, size: 18),
            const SizedBox(width: 8),
            Text('Método de Pago',
                style: TextStyle(
                    color: t.textPrimary, fontSize: 15, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 14),
        _paymentOption(Icons.credit_card, 'Tarjeta de Crédito/Débito', '•••• •••• •••• 4242', true),
        const SizedBox(height: 8),
        _paymentOption(Icons.account_balance_outlined, 'PSE', 'Pago en línea', false),
        const SizedBox(height: 8),
        _paymentOption(Icons.phone_android_rounded, 'Nequi / Daviplata', 'Transferencia móvil', false),
      ],
    ),
  );

  Widget _paymentOption(IconData icon, String title, String subtitle, bool selected) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: selected ? Colors.red.withOpacity(0.1) : t.cardColor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: selected ? Colors.red.withOpacity(0.5) : t.textSecondary.withOpacity(0.15),
      ),
    ),
    child: Row(
      children: [
        Icon(icon, color: selected ? Colors.red : t.textSecondary, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      color: selected ? t.textPrimary : t.textSecondary,
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.normal)),
              Text(subtitle,
                  style: TextStyle(color: t.textSecondary, fontSize: 11)),
            ],
          ),
        ),
        if (selected) const Icon(Icons.check_circle_rounded, color: Colors.red, size: 20),
      ],
    ),
  );

  Widget _buildPriceBreakdown() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: t.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: t.textSecondary.withOpacity(0.1)),
    ),
    child: Column(
      children: [
        _priceRow('${controller.selectedSeatIds.length} boleta(s) × \$15.000',
            '\$${controller.totalPrice.toStringAsFixed(0)}', t.textSecondary),
        const SizedBox(height: 8),
        _priceRow('Cargo por servicio', '\$2.000', t.textSecondary),
        const SizedBox(height: 8),
        _priceRow('Descuento', '-\$0', Colors.green),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Divider(color: t.textSecondary.withOpacity(0.2), height: 1),
        ),
        _priceRow('Total a pagar',
            '\$${(controller.totalPrice + 2000).toStringAsFixed(0)} COP',
            t.textPrimary,
            isBold: true),
      ],
    ),
  );

  Widget _priceRow(String label, String value, Color valueColor, {bool isBold = false}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label,
          style: TextStyle(
              color: isBold ? t.textSecondary : t.textSecondary.withOpacity(0.7),
              fontSize: isBold ? 14 : 13)),
      Text(value,
          style: TextStyle(
              color: valueColor,
              fontSize: isBold ? 16 : 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
    ],
  );

  Widget _buildPayButton() => ElevatedButton(
    onPressed: controller.confirmPayment,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      shadowColor: Colors.red.withOpacity(0.4),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock_rounded, size: 16),
        const SizedBox(width: 8),
        Text('Pagar \$${(controller.totalPrice + 2000).toStringAsFixed(0)} COP',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    ),
  );

  Widget _buildSecurityNote() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.verified_user_outlined, color: t.textSecondary, size: 13),
      const SizedBox(width: 5),
      Text('Pago seguro con cifrado SSL',
          style: TextStyle(color: t.textSecondary, fontSize: 11)),
    ],
  );
}
