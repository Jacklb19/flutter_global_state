import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/theme_controller.dart';
import 'splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    final t = Get.find<ThemeController>();
    return Obx(() => Scaffold(
      backgroundColor: t.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 5)
                ],
              ),
              child: const Icon(Icons.movie_filter_rounded,
                  color: Colors.white, size: 56),
            ),
            const SizedBox(height: 24),
            Text('CineApp',
                style: TextStyle(
                    color: t.textPrimary,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4)),
            const SizedBox(height: 8),
            Text('Tu cine, tu experiencia',
                style: TextStyle(color: t.textSecondary, fontSize: 14)),
            const SizedBox(height: 60),
            const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(color: Colors.red, strokeWidth: 2),
            ),
          ],
        ),
      ),
    ));
  }
}
