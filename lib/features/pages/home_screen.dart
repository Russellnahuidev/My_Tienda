import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/controllers/auth_controller.dart';
import 'package:my_tienda/controllers/theme_controller.dart';
import 'package:my_tienda/features/pages/all_products_screen.dart';
import 'package:my_tienda/features/pages/card_screen.dart';
import 'package:my_tienda/features/notifications/view/notifications_screen.dart';
import 'package:my_tienda/features/widgets/category_chips.dart';
import 'package:my_tienda/features/widgets/custom_search_bar.dart';
import 'package:my_tienda/features/widgets/product_grid.dart';
import 'package:my_tienda/features/widgets/sale_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            //header section
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: GetX<AuthController>(
                      builder: (authController) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello ${authController.userName?.split(' ').first ?? 'User'}',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          Text(
                            'Good Morning!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),

                  //notification icon
                  IconButton(
                    onPressed: () => Get.to(() => NotificationsScreen()),
                    icon: Icon(Icons.notifications_outlined),
                  ),

                  //card button
                  IconButton(
                    onPressed: () => Get.to(() => CardScreen()),
                    icon: Icon(Icons.shopping_bag_outlined),
                  ),

                  //theme button
                  GetBuilder<ThemeController>(
                    builder: (controller) => IconButton(
                      onPressed: () => controller.toggleTheme(),
                      icon: Icon(
                        controller.isDarkMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //search bar
            CustomSearchBar(),

            //category chips
            CategoryChips(),

            //sale banner
            SaleBanner(),

            //popupar product
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Product',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => AllProductsScreen()),
                    child: Text(
                      'See All',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),

            //product grid
            Expanded(child: ProductGrid()),
          ],
        ),
      ),
    );
  }
}
