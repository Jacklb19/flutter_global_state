import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    // ✅ onReady() en vez de onInit()
    // Se ejecuta DESPUÉS de que el widget está en pantalla
    super.onReady();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(AppRoutes.movies);
  }
}
