import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/movie_model.dart';
import '../../routes/app_routes.dart';
import '../theme/theme_controller.dart';
import 'movies_controller.dart';

class MoviesView extends GetView<MoviesController> {
  const MoviesView({super.key});

  // Acceso rápido al theme
  ThemeController get t => Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: t.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildBanner()),
          SliverToBoxAdapter(child: _buildSectionTitle('🎬 En Cartelera')),
          SliverToBoxAdapter(
              child: _buildHorizontalList(controller.nowPlaying)),
          SliverToBoxAdapter(
              child: _buildSectionTitle('🆕 Próximos Estrenos')),
          SliverToBoxAdapter(
              child: _buildHorizontalList(controller.comingSoon)),
          SliverToBoxAdapter(
              child: _buildSectionTitle('⭐ Todas las Películas')),
          SliverToBoxAdapter(child: _buildAllMoviesGrid()),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    ));
  }

  Widget _buildAppBar() => Obx(() => SliverAppBar(
    backgroundColor: t.surface,
    floating: true,
    title: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.movie_filter_rounded,
              color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Text('CineApp',
            style: TextStyle(
                color: t.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
      ],
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.search, color: t.textPrimary),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          t.isDark.value
              ? Icons.light_mode_rounded
              : Icons.dark_mode_rounded,
          color: t.isDark.value ? Colors.amber : Colors.blueGrey,
        ),
        onPressed: t.toggleTheme,
      ),
    ],
  ));

  Widget _buildBanner() => Obx(() => SizedBox(
    height: 220,
    child: PageView.builder(
      onPageChanged: controller.setBanner,
      itemCount: controller.featured.length,
      itemBuilder: (_, i) => _buildBannerCard(controller.featured[i]),
    ),
  ));

  Widget _buildBannerCard(Movie movie) => GestureDetector(
    onTap: () => Get.toNamed(AppRoutes.detail, arguments: movie),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(movie.imageUrl),
          fit: BoxFit.cover,
          onError: (_, __) {},
        ),
        color: t.cardColor,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.85),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (movie.isNew)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 3),
                margin: const EdgeInsets.only(bottom: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('ESTRENO',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              ),
            Text(movie.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 14),
                const SizedBox(width: 4),
                Text('${movie.score}',
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 12)),
                const SizedBox(width: 12),
                Text(movie.genre,
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 12)),
                const SizedBox(width: 12),
                Text(movie.duration,
                    style: const TextStyle(
                        color: Colors.white54, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildSectionTitle(String title) => Obx(() => Padding(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
    child: Text(title,
        style: TextStyle(
            color: t.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold)),
  ));

  Widget _buildHorizontalList(RxList<Movie> movies) => Obx(() => SizedBox(
    height: 200,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: movies.length,
      itemBuilder: (_, i) => _buildMovieCard(movies[i]),
    ),
  ));

  Widget _buildMovieCard(Movie movie) => Obx(() => GestureDetector(
    onTap: () => Get.toNamed(AppRoutes.detail, arguments: movie),
    child: Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                movie.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  color: t.cardColor,
                  child: Icon(Icons.movie_rounded,
                      color: t.textSecondary, size: 30),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: t.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 11),
              const SizedBox(width: 3),
              Text('${movie.score}',
                  style: TextStyle(
                      color: t.textSecondary, fontSize: 11)),
            ],
          ),
        ],
      ),
    ),
  ));

  Widget _buildAllMoviesGrid() => Obx(() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      childAspectRatio: 0.6,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: controller.allMovies.length,
    itemBuilder: (_, i) => _buildMovieCard(controller.allMovies[i]),
  ));
}
