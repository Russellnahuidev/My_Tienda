import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/controllers/product_controller.dart';
import 'package:my_tienda/features/pages/product_detail_screen.dart';
import 'package:my_tienda/features/widgets/product_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (productController) {
        if (productController.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (productController.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                SizedBox(height: 16),
                Text(
                  productController.errorMessage,
                  style: TextStyle(color: Colors.grey[400], fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => productController.refreshProducts(),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        final displayProducsts = productController.getDisplayProducts();

        if (displayProducsts.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16),
                Text(
                  'No products available',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => productController.refreshProducts(),
                  child: Text('Refresh'),
                ),
              ],
            ),
          );
        }
        return GridView.builder(
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: displayProducsts.length,
          itemBuilder: (context, index) {
            final product = displayProducsts[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              ),
              child: ProductCard(product: product),
            );
          },
        );
      },
    );
  }
}
