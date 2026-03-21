import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/controllers/category_controller.dart';
import 'package:my_tienda/controllers/product_controller.dart';
import 'package:my_tienda/utils/app_textStyles.dart';

class CategoryChips extends StatefulWidget {
  const CategoryChips({super.key});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GetBuilder<ProductController>(
      builder: (productController) {
        final categoryController = Get.find<CategoryController>();
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
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),
          );
        }

        final categories = categoryController.getCategoriesWithFallback();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: List.generate(
              categories.length,
              (index) => Padding(
                padding: EdgeInsets.only(right: 12),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: ChoiceChip(
                    label: Text(
                      categories[index],
                      style: AppTextStyles.withColor(
                        productController.selectedCategory == categories[index]
                            ? AppTextStyles.withWeight(
                                AppTextStyles.bodySmall,
                                FontWeight.w600,
                              )
                            : AppTextStyles.bodySmall,
                        productController.selectedCategory == categories[index]
                            ? Colors.white
                            : isDark
                            ? Colors.grey[300]!
                            : Colors.grey[600]!,
                      ),
                    ),
                    selected:
                        productController.selectedCategory == categories[index],
                    onSelected: (bool selected) {
                      if (selected) {
                        //Update both controllers
                        categoryController.selectCategory(categories[index]);
                        productController.filterByCategory(categories[index]);
                      }
                    },
                    selectedColor: Theme.of(context).primaryColor,
                    backgroundColor: isDark
                        ? Colors.grey[800] // Darker backround for dark mode
                        : Colors.grey[100], // Ligth background for ligth mode
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                    elevation:
                        productController.selectedCategory == categories[index]
                        ? 2
                        : 0,
                    pressElevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 1,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: BorderSide(
                      color:
                          productController.selectedCategory ==
                              categories[index]
                          ? Colors.transparent
                          : isDark
                          ? Colors.grey[700]! // Darker backround for dark mode
                          : Colors
                                .grey[300]!, // Ligth background for ligth mode
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
