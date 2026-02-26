import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final RxBool isDark = true.obs;

  void toggleTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Colores reactivos — úsalos en cualquier widget
  Color get background  => isDark.value ? const Color(0xFF0A0A1A) : const Color(0xFFF5F5F5);
  Color get surface     => isDark.value ? const Color(0xFF12122A) : Colors.white;
  Color get cardColor   => isDark.value ? const Color(0xFF1E1E3A) : const Color(0xFFEEEEEE);
  Color get textPrimary => isDark.value ? Colors.white : Colors.black87;
  Color get textSecondary => isDark.value ? Colors.white54 : Colors.black45;
}
