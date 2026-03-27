import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/controllers/category_controller.dart';
import 'package:my_tienda/controllers/product_controller.dart';
import 'package:my_tienda/utils/app_textstyles.dart';

class FilterButtomSheet {
  static void show(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productController = Get.find<ProductController>();

    //Local state for the filter sheet
    String selecctedCategory = productController.selectedCategory;
    final minPriceController = TextEditingController(
      text: productController.minPrice > 0
          ? productController.minPrice.toString()
          : '',
    );
    final maxPriceController = TextEditingController(
      text: productController.maxPrice < double.infinity
          ? productController.maxPrice.toString()
          : '',
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSatate) => Container(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter Products',
                      style: AppTextStyles.withColor(
                        AppTextStyles.h3,
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.close,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),
                Text(
                  'Price Range',
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodyLarge,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),

                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: minPriceController,
                        decoration: InputDecoration(
                          hintText: 'Min',
                          prefixText: '\$',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDark
                                  ? Colors.grey[700]!
                                  : Colors.grey[300]!,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: maxPriceController,
                        decoration: InputDecoration(
                          hintText: 'Max',
                          prefixText: '\$',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: isDark
                                  ? Colors.grey[700]!
                                  : Colors.grey[300]!,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),
                Text(
                  'Categories',
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodyLarge,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),

                SizedBox(height: 16),
                GetBuilder<CategoryController>(
                  builder: (categoryController) {
                    if (categoryController.isLoading) {
                      return SizedBox(
                        height: 50,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (categoryController.hasError) {
                      return SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            'Failed to load categories',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }

                    final categories = categoryController.categoryName;
                    return Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: categories
                          .map(
                            (category) => FilterChip(
                              label: Text(category),
                              selected: category == selecctedCategory,
                              onSelected: (selected) {
                                if (selected) {
                                  if (selected) {
                                    setSatate(() {
                                      selecctedCategory = category;
                                    });
                                  }
                                }
                              },
                              backgroundColor: Theme.of(context).cardColor,
                              selectedColor: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.2),
                              labelStyle: AppTextStyles.withColor(
                                AppTextStyles.bodyMedium,
                                category == selecctedCategory
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(
                                        context,
                                      ).textTheme.bodyLarge!.color!,
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      //Apply filters
                      double minPrice = 0.0;
                      double maxPrice = double.infinity;

                      if (minPriceController.text.isNotEmpty) {
                        minPrice =
                            double.tryParse(minPriceController.text) ?? 0.0;
                      }

                      if (maxPriceController.text.isNotEmpty) {
                        maxPrice =
                            double.tryParse(maxPriceController.text) ??
                            double.infinity;
                      }

                      //Apply category filter
                      productController.filterByCategory(selecctedCategory);

                      //Apply price filter
                      productController.setPriceRange(minPrice, maxPrice);

                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodyMedium,
                        Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      setSatate(() {
                        selecctedCategory = '';
                        minPriceController.clear();
                        maxPriceController.clear();
                      });
                      productController.resetFilters();
                      Get.back();
                    },
                    child: Text(
                      'Reset Filters',
                      style: AppTextStyles.withColor(
                        AppTextStyles.buttonMedium,
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
