import 'package:flutter/material.dart';
import 'package:my_tienda/utils/app_textstyles.dart';
import 'package:my_tienda/features/widgets/category_chips.dart';
import 'package:my_tienda/features/widgets/filter_buttom_sheet.dart';
import 'package:my_tienda/features/widgets/product_grid.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Shopping',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          //search icon
          IconButton(
            onPressed: () {},
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
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 16), child: CategoryChips()),
          Expanded(child: ProductGrid()),
        ],
      ),
    );
  }
}
