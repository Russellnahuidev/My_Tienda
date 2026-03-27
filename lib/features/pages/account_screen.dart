import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/controllers/auth_controller.dart';
import 'package:my_tienda/features/edit_profile/screens/edit_profile_screen.dart';
import 'package:my_tienda/features/help_center/views/screen/help_center_screen.dart';
import 'package:my_tienda/features/my_orders/view/screens/my_orders_screen.dart';
import 'package:my_tienda/features/shippin_address/shipping_address_screen.dart';
import 'package:my_tienda/utils/app_textstyles.dart';
import 'package:my_tienda/features/pages/setting_screen.dart';
import 'package:my_tienda/features/auth/signin_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => SettingScreen()),
            icon: Icon(
              Icons.settings_outlined,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSelection(context),

            SizedBox(height: 16),

            _buildMenuSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSelection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final AuthController authController = Get.find<AuthController>();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
          Obx(
            () => Text(
              authController.userName ?? 'User',
              style: AppTextStyles.withColor(
                AppTextStyles.h2,
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
          ),

          SizedBox(height: 4),
          Obx(
            () => Text(
              authController.userEmail ?? '',
              style: AppTextStyles.withColor(
                AppTextStyles.bodyMedium,
                isDark ? Colors.grey[400]! : Colors.grey[600]!,
              ),
            ),
          ),

          SizedBox(height: 16),

          OutlinedButton(
            onPressed: () => Get.to(() => EditProfileScreen()),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              side: BorderSide(color: isDark ? Colors.white70 : Colors.black12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Edit Profile',
              style: AppTextStyles.withColor(
                AppTextStyles.buttonMedium,
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final menuItems = [
      {'icon': Icons.shopping_bag_outlined, 'title': 'My Orders'},
      {'icon': Icons.location_on_outlined, 'title': 'Shipping Adress'},
      {'icon': Icons.help_outline, 'title': 'Help Ccenter'},
      {'icon': Icons.logout_outlined, 'title': 'Logout'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: menuItems.map((item) {
          return Container(
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: Icon(
                item['icon'] as IconData,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                item['title'] as String,
                style: AppTextStyles.withColor(
                  AppTextStyles.bodyMedium,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              onTap: () {
                if (item['title'] == 'Logout') {
                  _showLogoutDialog(context);
                } else if (item['title'] == 'My Orders') {
                  Get.to(() => MyOrdersScreen());
                } else if (item['title'] == 'Shipping Adress') {
                  Get.to(() => ShippingAddressScreen());
                } else if (item['title'] == 'Help Ccenter') {
                  Get.to(() => HelpCenterScreen());
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                color: Theme.of(context).primaryColor,
                size: 32,
              ),
            ),

            SizedBox(height: 8),

            Text(
              'Are you sure want to logout?',
              style: AppTextStyles.withColor(
                AppTextStyles.bodyMedium,
                isDark ? Colors.grey[400]! : Colors.grey[600]!,
              ),
            ),

            SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(
                        color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodyMedium,
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final AuthController authController =
                          Get.find<AuthController>();

                      //show loading indicator
                      Get.dialog(
                        Center(child: CircularProgressIndicator()),
                        barrierDismissible: false,
                      );
                      try {
                        final result = await authController.signOut();
                        //close loading dialog
                        Get.back();
                        if (result.succes) {
                          Get.snackbar(
                            'Succes',
                            result.message,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                          Get.offAll(() => SigninScreen());
                        } else {
                          Get.snackbar(
                            'Error',
                            result.message,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      } catch (e) {
                        //Close loading dialog
                        Get.back();
                        Get.snackbar(
                          'Error',
                          'An unexpected error occurred. Please try again.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodyMedium,
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
