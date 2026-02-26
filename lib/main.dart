import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CineApp',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash, // ahora apunta a '/splash'
      getPages: AppPages.pages,
    );
  }
}
