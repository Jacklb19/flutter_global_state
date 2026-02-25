import 'package:get/get.dart';
import '../../data/models/seat_model.dart';

class HomeController extends GetxController {
  static const int    maxSelection  = 4;
  static const double pricePerSeat  = 15000;

  final List<Seat> seats = [];
  final RxInt    selectedCount = 0.obs;
  final RxDouble totalPrice   = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _generateSeats();
  }

  void _generateSeats() {
    const rows     = ['A', 'B', 'C', 'D', 'E'];
    const occupied = {2, 7, 15, 23, 31};
    int i = 0;
    for (final row in rows) {
      for (int n = 1; n <= 10; n++) {
        seats.add(Seat(
          id: '$row$n',
          initialStatus:
          occupied.contains(i) ? SeatStatus.occupied : SeatStatus.available,
        ));
        i++;
      }
    }
  }

  List<Seat> get selectedSeats =>
      seats.where((s) => s.status.value == SeatStatus.selected).toList();

  void toggleSeat(Seat seat) {
    if (seat.status.value == SeatStatus.occupied) return;

    if (seat.status.value == SeatStatus.selected) {
      seat.status.value = SeatStatus.available;
      selectedCount.value--;
    } else {
      if (selectedCount.value >= maxSelection) {
        Get.snackbar(
          'Límite alcanzado',
          'Máximo $maxSelection boletas por compra',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
        return;
      }
      seat.status.value = SeatStatus.selected;
      selectedCount.value++;
    }
    totalPrice.value = selectedCount.value * pricePerSeat;
  }

  void markSelectedAsOccupied() {
    for (final s in seats) {
      if (s.status.value == SeatStatus.selected) {
        s.status.value = SeatStatus.occupied;
      }
    }
    selectedCount.value = 0;
    totalPrice.value    = 0;
  }

  void releaseSelectedSeats() {
    for (final s in seats) {
      if (s.status.value == SeatStatus.selected) {
        s.status.value = SeatStatus.available;
      }
    }
    selectedCount.value = 0;
    totalPrice.value    = 0;
  }
}
