import 'package:flutter/material.dart';
import 'package:my_tienda/models/product.dart';
import 'package:my_tienda/utils/app_textstyles.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      constraints: BoxConstraints(maxWidth: screenWidth * 0.9),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              //image
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                    // loadingBuilder: (context, child, loadingProgress) {
                    //   if (loadingProgress == null) return child;

                    //   return Center(
                    //     child: CircularProgressIndicator(
                    //       value: loadingProgress.expectedTotalBytes != null
                    //           ? loadingProgress.cumulativeBytesLoaded /
                    //                 loadingProgress.expectedTotalBytes!
                    //           : null,
                    //     ),
                    //   );
                    // },
                  ),
                ),
              ),

              //favorite button
              Positioned(
                right: 8,
                top: 8,
                child: IconButton(
                  onPressed: () {
                    //Implement favorite toggle funcionatily
                  },
                  icon: Icon(Icons.favorite_border, color: Colors.grey),
                ),
              ),
              if (product.oldPrice != null)
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    //discount text
                    child: Text(
                      '${calculateDiscount(product.price, product.oldPrice!)}% OFF',
                      style: AppTextStyles.withColor(
                        AppTextStyles.withWeight(
                          AppTextStyles.bodySmall,
                          FontWeight.bold,
                        ),
                        Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          //product detail
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: AppTextStyles.withColor(
                    AppTextStyles.withWeight(AppTextStyles.h3, FontWeight.bold),
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: screenWidth * 0.01),

                Text(
                  product.category,
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodyMedium,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),

                SizedBox(height: screenWidth * 0.01),

                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.withColor(
                        AppTextStyles.withWeight(
                          AppTextStyles.h3,
                          FontWeight.bold,
                        ),
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                    if (product.oldPrice != null) ...[
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        '\$${product.oldPrice!.toStringAsFixed(2)}',
                        style: AppTextStyles.withColor(
                          AppTextStyles.bodySmall,

                          isDark ? Colors.grey[400]! : Colors.grey[600]!,
                        ).copyWith(decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //calculate discount
  int calculateDiscount(double currentPrice, double oldPrice) {
    return (((oldPrice - currentPrice) / oldPrice * 100).round());
  }
}
