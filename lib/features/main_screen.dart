import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/controllers/navigation_controller.dart';
import 'package:my_tienda/controllers/theme_controller.dart';
import 'package:my_tienda/features/account_screen.dart';
import 'package:my_tienda/features/home_screen.dart';
import 'package:my_tienda/features/shopping_screen.dart';
import 'package:my_tienda/features/widgets/custom_botton_navbar.dart';
import 'package:my_tienda/features/wishlist_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController =
        Get.find<NavigationController>();
    return GetBuilder<ThemeController>(
      builder: (themeController) => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: Obx(
            () => IndexedStack(
              key: ValueKey(navigationController.currentIndex.value),
              index: navigationController.currentIndex.value,
              children: [
                HomeScreen(),
                ShoppingScreen(),
                WishlistScreen(),
                AccountScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottonNavbar(),
      ),
    );
  }
}
