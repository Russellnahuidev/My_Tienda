import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_tienda/controllers/auth_controller.dart';
import 'package:my_tienda/controllers/navigation_controller.dart';
import 'package:my_tienda/controllers/product_controller.dart';
import 'package:my_tienda/controllers/theme_controller.dart';
import 'package:my_tienda/firebase_options.dart';
import 'package:my_tienda/utils/app_themes.dart';
import 'package:my_tienda/features/pages/splash_screen.dart';
import 'package:my_tienda/utils/firestore_data_seeder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  Get.put(ThemeController());
  Get.put(AuthController());
  Get.put(ProductController());
  Get.put(NavigationController());

  //The line below is used to seed sample data to firestore (for testing only)
  await FirestoreDataSeeder.seeAllData();
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
