import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_tienda/controllers/auth_controller.dart';
import 'package:my_tienda/controllers/navigation_controller.dart';
import 'package:my_tienda/controllers/theme_controller.dart';
import 'package:my_tienda/utils/app_themes.dart';
import 'package:my_tienda/views/splash_screen.dart';

void main() async {
  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(AuthController());
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Tienda',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeController.theme,
      defaultTransition: Transition.fade,
      home: SplashScreen(),
    );
  }
}
