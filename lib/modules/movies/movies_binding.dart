import 'package:get/get.dart';
import 'movies_controller.dart';

class MoviesBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => MoviesController());
}
