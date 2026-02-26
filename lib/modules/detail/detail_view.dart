import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/theme_controller.dart';
import 'detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});

  ThemeController get t => Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final movie = controller.movie;
    return Obx(() => Scaffold(
      backgroundColor: t.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 380,
            pinned: true,
            backgroundColor: t.background,
            iconTheme: IconThemeData(color: t.textPrimary),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(movie.imageUrl, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: t.cardColor,
                        child: Icon(Icons.movie_rounded,
                            color: t.textSecondary, size: 60),
                      )),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black.withOpacity(0.3), t.background],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(movie.title,
                            style: TextStyle(
                                color: t.textPrimary,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                      ),
                      if (movie.isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.red, borderRadius: BorderRadius.circular(6)),
                          child: const Text('ESTRENO',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _chip(Icons.star, '${movie.score}', Colors.amber),
                      _chip(Icons.category_outlined, movie.genre, Colors.blueGrey),
                      _chip(Icons.timer_outlined, movie.duration, Colors.blueGrey),
                      _chip(Icons.label_outline, movie.rating, Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Sinopsis',
                      style: TextStyle(
                          color: t.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(movie.synopsis,
                      style: TextStyle(color: t.textSecondary, fontSize: 14, height: 1.6)),
                  const SizedBox(height: 32),
                  _buildShowtimes(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: controller.goToSeats,
                      icon: const Icon(Icons.event_seat_rounded),
                      label: const Text('Seleccionar Asientos',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _chip(IconData icon, String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: color.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 13),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    ),
  );

  Widget _buildShowtimes() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Horarios de Hoy',
          style: TextStyle(color: t.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: ['2:00 PM', '4:30 PM', '7:00 PM', '9:30 PM', '11:50 PM']
            .map((time) => GestureDetector(
          onTap: controller.goToSeats,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red.withOpacity(0.6)),
              borderRadius: BorderRadius.circular(10),
              color: Colors.red.withOpacity(0.1),
            ),
            child: Text(time,
                style: TextStyle(
                    color: t.textPrimary, fontWeight: FontWeight.w600)),
          ),
        ))
            .toList(),
      ),
    ],
  );
}
