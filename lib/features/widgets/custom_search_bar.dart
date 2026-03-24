import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/controllers/product_controller.dart';
import 'package:my_tienda/features/pages/search_results_screen.dart';
import 'package:my_tienda/utils/app_textstyles.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        style: AppTextStyles.withColor(
          AppTextStyles.buttonMedium,
          Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: AppTextStyles.withColor(
            AppTextStyles.buttonMedium,
            isDark ? Colors.grey[400]! : Colors.grey[600]!,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          suffixIcon: GetBuilder<ProductController>(
            builder: (productController) {
              return _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        productController.clearSearch();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.clear,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                      ),
                    )
                  : Icon(
                      Icons.tune,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    );
            },
          ),
          filled: true,
          fillColor: isDark ? Colors.grey[800] : Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDark ? Colors.grey[400]! : Colors.grey[600]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1,
            ),
          ),
        ),
        onChanged: (value) {
          setState(() {}); //Rubuild to show/hide clear button
        },
        onSubmitted: _performSearch,
        onTap: () {
          //Navigate to search screen when tapped
          Get.to(
            () => SearchResultsScreen(searchQuery: _searchController.text),
          );
        },
      ),
    );
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;

    final productController = Get.find<ProductController>();
    productController.searchProducts(query.trim());

    //Navigate to search results screen
    Get.to(() => SearchResultsScreen(searchQuery: query.trim()));
  }
}
