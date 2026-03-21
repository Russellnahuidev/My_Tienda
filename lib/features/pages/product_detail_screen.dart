import 'package:flutter/material.dart';
import 'package:my_tienda/models/product.dart';
import 'package:my_tienda/utils/app_textstyles.dart';
import 'package:my_tienda/features/widgets/size_selector.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Details',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),

        //share button
        actions: [
          IconButton(
            onPressed: () => _shareProduct(
              context,
              widget.product.name,
              widget.product.description,
            ),
            icon: Icon(
              Icons.share_outlined,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                //image
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    widget.product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),

                //favorite button
                Positioned(
                  right: screenWidth * 0.04,
                  top: screenHeight * 0.04,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border, color: Colors.white),
                  ),
                ),
              ],
            ),

            //Prodcut detail
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: AppTextStyles.withColor(
                            AppTextStyles.h2,
                            Theme.of(context).textTheme.headlineMedium!.color!,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            '\$${widget.product.price.toStringAsFixed(2)}',
                            style: AppTextStyles.withColor(
                              AppTextStyles.h2,
                              Theme.of(
                                context,
                              ).textTheme.headlineMedium!.color!,
                            ),
                          ),
                          if (widget.product.oldPrice != null &&
                              widget.product.oldPrice! >
                                  widget.product.price) ...[
                            Text(
                              '\$${widget.product.oldPrice!.toStringAsFixed(2)}',
                              style:
                                  AppTextStyles.withColor(
                                    AppTextStyles.bodySmall,
                                    isDark
                                        ? Colors.grey[400]!
                                        : Colors.grey[600]!,
                                  ).copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${widget.product.discountPercentage}% OFF',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.product.category,
                        style: AppTextStyles.withColor(
                          AppTextStyles.bodyMedium,
                          isDark ? Colors.grey[400]! : Colors.grey[600]!,
                        ),
                      ),
                      if (widget.product.brand != null) ...[
                        Text(
                          ' . ',
                          style: AppTextStyles.withColor(
                            AppTextStyles.bodyMedium,
                            isDark ? Colors.grey[400]! : Colors.grey[600]!,
                          ),
                        ),
                        Text(
                          widget.product.brand!,
                          style: AppTextStyles.withColor(
                            AppTextStyles.bodyMedium,
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  //stock status
                  if (widget.product.stock >= 5 && widget.product.stock >= 0)
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'Only ${widget.product.stock} lefy in stock!',
                        style: AppTextStyles.withColor(
                          AppTextStyles.bodySmall,
                          Colors.orange,
                        ),
                      ),
                    )
                  else if (widget.product.stock == 0)
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'Out of stock!',
                        style: AppTextStyles.withColor(
                          AppTextStyles.bodySmall,
                          Colors.red,
                        ),
                      ),
                    ),

                  SizedBox(height: screenHeight * 0.02),

                  //Show size selector only if sizes are available
                  if (_getAvailableSizes().isNotEmpty) ...[
                    Text(
                      'Select Size',
                      style: AppTextStyles.withColor(
                        AppTextStyles.labelMedium,
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    //size slector with product sizes
                    SizeSelector(
                      sizes: _getAvailableSizes(),
                      onSizeSelected: (size) {
                        //Handle size selection
                        //you can ad size selection logic here
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],

                  SizedBox(height: screenHeight * 0.02),

                  //Description
                  Text(
                    'Description',
                    style: AppTextStyles.withColor(
                      AppTextStyles.labelMedium,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  //Description text
                  Text(
                    widget.product.description,
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodySmall,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //buttons
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0),
                    side: BorderSide(
                      color: isDark ? Colors.white70 : Colors.black12,
                    ),
                  ),
                  child: Text(
                    'Add to Card',
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodyMedium,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.04),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'Buy Now',
                    style: AppTextStyles.withColor(
                      AppTextStyles.bodyMedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //share product
  Future<void> _shareProduct(
    BuildContext context,
    String productName,
    String description,
  ) async {
    //get the render box for share position origin (required for iPad)
    final box = context.findRenderObject() as RenderBox?;

    const String shopLink = 'https://www.mytienda.com/product/cotton-tshirt';
    final String shareMessage = '$description\n\nShop now at $shopLink';

    try {
      final ShareResult result = await Share.share(
        shareMessage,
        subject: productName,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
      if (result.status == ShareResultStatus.success) {
        debugPrint('Thank you for sharing!');
      }
    } catch (e) {
      debugPrint('Error Sharing: $e');
    }
  }

  //Get availables sizes from product specifications
  List<String> _getAvailableSizes() {
    if (widget.product.specifications.containsKey('sizes')) {
      final sizes = widget.product.specifications['sizes'];
      if (sizes is List) {
        return List<String>.from(sizes);
      }
    }
    return [];
  }
}
