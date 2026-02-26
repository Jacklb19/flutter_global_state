import 'package:get/get.dart';
import '../../data/models/movie_model.dart';

class MoviesController extends GetxController {
  final RxList<Movie> allMovies    = <Movie>[].obs;
  final RxList<Movie> featured     = <Movie>[].obs;
  final RxList<Movie> nowPlaying   = <Movie>[].obs;
  final RxList<Movie> comingSoon   = <Movie>[].obs;
  final RxInt currentBanner        = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadMovies();
  }

  void _loadMovies() {
    allMovies.assignAll(mockMovies);
    featured.assignAll(mockMovies.take(3).toList());
    nowPlaying.assignAll(mockMovies.where((m) => !m.isNew).toList());
    comingSoon.assignAll(mockMovies.where((m) => m.isNew).toList());
  }

  void setBanner(int index) => currentBanner.value = index;
}
