import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_tienda/features/home_screen.dart';
import 'package:my_tienda/features/my_orders/view/screens/my_orders_screen.dart';
import 'package:my_tienda/utils/app_textstyles.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderNumber;
  final double totalAmooun;
  const OrderConfirmationScreen({
    super.key,
    required this.orderNumber,
    required this.totalAmooun,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/order_success.json',
                width: 200,
                height: 200,
                repeat: false,
              ),
              SizedBox(height: 32),
              Text(
                'Order Confirmed!',
                textAlign: TextAlign.center,
                style: AppTextStyles.withColor(
                  AppTextStyles.h2,
                  isDark ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Your order #$orderNumber has been successfully placed.',
                textAlign: TextAlign.center,
                style: AppTextStyles.withColor(
                  AppTextStyles.bodyLarge,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => MyOrdersScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                child: Text(
                  'Track Order',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.withColor(
                    AppTextStyles.buttonMedium,
                    Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 13),
              TextButton(
                onPressed: () {
                  Get.offAll(() => HomeScreen());
                },
                child: Text(
                  'Continue Shopping',
                  style: AppTextStyles.withColor(
                    AppTextStyles.buttonMedium,
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
