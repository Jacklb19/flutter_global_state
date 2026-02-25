import 'package:get/get.dart';

enum SeatStatus { available, selected, occupied }

class Seat {
  final String id;
  final Rx<SeatStatus> status;

  Seat({required this.id, SeatStatus initialStatus = SeatStatus.available})
      : status = initialStatus.obs;
}
