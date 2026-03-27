import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/features/pages/search_results_screen.dart';
import 'package:my_tienda/utils/app_textstyles.dart';
import 'package:my_tienda/features/widgets/filter_buttom_sheet.dart';
import 'package:my_tienda/features/widgets/product_grid.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'All Products',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          //search icon
          IconButton(
            onPressed: () {
              Get.to(() => SearchResultsScreen(searchQuery: ''));
            },
            icon: Icon(
              Icons.search,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),

          //filter icon
          IconButton(
            onPressed: () => FilterButtomSheet.show(context),
            icon: Icon(
              Icons.filter_list,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: ProductGrid(),
    );
  }
}
