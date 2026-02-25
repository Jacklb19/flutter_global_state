import 'package:get/get.dart';
import 'checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    // Sin fenix ni permanent: el Timer vive solo mientras esta pantalla esté activa.
    // onClose() se dispara automáticamente al hacer pop → cero memory leaks.
    Get.lazyPut<CheckoutController>(() => CheckoutController());
  }
}
