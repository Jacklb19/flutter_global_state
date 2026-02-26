import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'modules/theme/theme_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  Get.put(ThemeController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();
    return Obx(() {
      // Este Obx hace que GetMaterialApp se reconstruya al cambiar isDark
      final isDark = theme.isDark.value;
      return GetMaterialApp(
        title: 'CineApp',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
        themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: const Color(0xFF0A0A1A),
          cardColor: const Color(0xFF12122A),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          colorScheme: const ColorScheme.dark(
            primary: Colors.red,
            surface: Color(0xFF12122A),
          ),
        ),
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          cardColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 0,
          ),
          colorScheme: const ColorScheme.light(
            primary: Colors.red,
            surface: Colors.white,
          ),
        ),
        onReady: () async {
          await Future.delayed(const Duration(seconds: 3));
          Get.offAllNamed(AppRoutes.movies);
        },
      );
    });
  }
}
