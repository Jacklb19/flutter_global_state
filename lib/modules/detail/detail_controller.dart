import 'package:get/get.dart';
import '../../data/models/movie_model.dart';
import '../../routes/app_routes.dart';

class DetailController extends GetxController {
  late final Movie movie;

  @override
  void onInit() {
    super.onInit();
    // La película llega por Get.toNamed(arguments: movie)
    movie = Get.arguments as Movie;
  }

  void goToSeats() => Get.toNamed(AppRoutes.home);
}
