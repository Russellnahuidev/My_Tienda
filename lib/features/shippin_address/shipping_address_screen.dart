import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/features/shippin_address/models/address.dart';
import 'package:my_tienda/features/shippin_address/repositories/address_repository.dart';
import 'package:my_tienda/features/shippin_address/widgets/address_card.dart';
import 'package:my_tienda/utils/app_textstyles.dart';

class ShippingAddressScreen extends StatelessWidget {
  final AddressRepository _repository = AddressRepository();
  ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Shipping Address',
          style: AppTextStyles.withColor(
            AppTextStyles.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _showAddAddreesBotomShet(context),
            icon: Icon(
              Icons.add_circle_outline,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _repository.getAddresses().length,
        itemBuilder: (context, index) => _buildAddressCard(context, index),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, int index) {
    final address = _repository.getAddresses()[index];

    return AddressCard(
      address: address,
      onEdit: () => _showEditAddressBottomSheet(context, address),
      onDelete: () => _showDeleteonfirmation(context),
    );
  }

  void _showEditAddressBottomSheet(BuildContext context, Address address) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit Address',
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

            _buildTextField(
              context,
              'Label (e.g. Home, Office)',
              Icons.label_outline,
              initialValue: address.label,
            ),

            SizedBox(height: 16),

            _buildTextField(
              context,
              'Full Adrees',
              Icons.location_on_outlined,
              initialValue: address.fullAddress,
            ),

            SizedBox(height: 16),

            _buildTextField(
              context,
              'City',
              Icons.location_city_outlined,
              initialValue: address.city,
            ),

            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    context,
                    'State',
                    Icons.map_outlined,
                    initialValue: address.state,
                  ),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: _buildTextField(
                    context,
                    'ZIP Code',
                    Icons.pin_outlined,
                    initialValue: address.zipCode,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //handle update addres
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                ),
                child: Text(
                  'Update Address',
                  style: AppTextStyles.withColor(
                    AppTextStyles.bodyMedium,
                    Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showDeleteonfirmation(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.dialog(
      AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        contentPadding: EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.delete_outline, color: Colors.red, size: 32),
            ),
            SizedBox(height: 16),
            Text(
              'Delete Address',
              style: AppTextStyles.withColor(
                AppTextStyles.h3,
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Are you sure you want to delete this address?',
              textAlign: TextAlign.center,
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
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.withColor(
                        AppTextStyles.buttonMedium,
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      //Handle delete address
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: AppTextStyles.withColor(
                        AppTextStyles.buttonMedium,
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
      barrierColor: Colors.black54,
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    IconData icon, {
    String? initialValue,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  void _showAddAddreesBotomShet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add New Address',
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
            _buildTextField(
              context,
              'Label (e.g. Home, Office)',
              Icons.label_outlined,
            ),
            SizedBox(height: 16),
            _buildTextField(
              context,
              'Full Address',
              Icons.location_on_outlined,
            ),
            SizedBox(height: 16),
            _buildTextField(context, 'City', Icons.location_city_outlined),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(context, 'State', Icons.map_outlined),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    context,
                    'ZIP Code',
                    Icons.pin_outlined,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //handle save address
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
                  'Save Address',
                  style: AppTextStyles.withColor(
                    AppTextStyles.buttonMedium,
                    Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
