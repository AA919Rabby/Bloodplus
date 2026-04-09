import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ui/themes/all_themes.dart';

class DarkmodeController extends GetxController {
  // This makes the UI refresh when you toggle
  var isDark = false.obs;

  void toggleMode() {
    isDark.value = !isDark.value;
    AllThemes.isDarkMode = isDark.value; // Sync with your AllThemes class

    // THIS is required to change the Scaffold background in main.dart!
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);

    update();
  }
}