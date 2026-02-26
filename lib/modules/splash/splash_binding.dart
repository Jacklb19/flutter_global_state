import 'package:get/get.dart';
import 'splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController()); // ✅ put() instancia inmediatamente
    // ❌ lazyPut solo instancia cuando alguien hace Get.find(), nunca se llama
  }
}
