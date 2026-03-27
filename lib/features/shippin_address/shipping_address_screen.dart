import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_tienda/controllers/address_controller.dart';
import 'package:my_tienda/features/shippin_address/models/address.dart';
import 'package:my_tienda/features/shippin_address/widgets/address_card.dart';
import 'package:my_tienda/utils/app_textstyles.dart';

class ShippingAddressScreen extends StatefulWidget {
  ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final _controller = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
      body: GetBuilder<AddressController>(
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${controller.errorMessage}',
                    style: AppTextStyles.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.loadAddresses(),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (controller.addresses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No addresses found', style: AppTextStyles.bodyMedium),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _showAddAddreesBotomShet(context),
                    child: Text('Add Address'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: _controller.addresses.length,
            itemBuilder: (context, index) => _buildAddressCard(context, index),
          );
        },
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, int index) {
    final address = _controller.addresses[index];

    return AddressCard(
      address: address,
      onEdit: () => _showEditAddressBottomSheet(context, address),
      onDelete: () => _showDeleteonfirmation(context, address.id),
      onSetDefault: () async {
        final success = await _controller.setDefaultAddress(address.id);
        if (success) {
          Get.snackbar('Succes', 'Default address update');
        } else {
          Get.snackbar('Error', 'Failed to update default address');
        }
      },
    );
  }

  void _showEditAddressBottomSheet(BuildContext context, Address address) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    //Text controllers for from fields
    final labelController = TextEditingController(text: address.label);
    final fullAddressController = TextEditingController(
      text: address.fullAddress,
    );
    final cityController = TextEditingController(text: address.city);
    final stateController = TextEditingController(text: address.state);
    final zipCodeController = TextEditingController(text: address.zipCode);

    //Address tye check box
    final selectedType = AddressType.home.obs;

    //Set as default checkbox
    final isDefault = (_controller.addresses.isEmpty).obs;

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
            TextField(
              controller: labelController,
              decoration: InputDecoration(
                labelText: 'Label (e.g. Home, Office)',
                prefixIcon: Icon(Icons.label_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 16),

            Text('Address Type', style: AppTextStyles.bodyMedium),

            SizedBox(height: 8),

            Obx(
              () => Row(
                children: [
                  _buildAddressTypeChip(
                    context,
                    'Home',
                    AddressType.home,
                    selectedType.value,
                    () => selectedType.value = AddressType.home,
                  ),
                  SizedBox(width: 8),
                  _buildAddressTypeChip(
                    context,
                    'Office',
                    AddressType.office,
                    selectedType.value,
                    () => selectedType.value = AddressType.office,
                  ),
                  SizedBox(width: 8),
                  _buildAddressTypeChip(
                    context,
                    'Other',
                    AddressType.other,
                    selectedType.value,
                    () => selectedType.value = AddressType.other,
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Obx(
              () => CheckboxListTile(
                title: Text(
                  'Set as default address',
                  style: AppTextStyles.bodyMedium,
                ),
                value: isDefault.value,
                onChanged: (value) => isDefault.value = value ?? false,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),

            SizedBox(height: 16),

            TextField(
              controller: fullAddressController,
              decoration: InputDecoration(
                labelText: 'Full Address',
                prefixIcon: Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'City',
                prefixIcon: Icon(Icons.location_city_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: stateController,
                    decoration: InputDecoration(
                      labelText: 'State',
                      prefixIcon: Icon(Icons.map_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: zipCodeController,
                    decoration: InputDecoration(
                      labelText: 'ZIP Code',
                      prefixIcon: Icon(Icons.pin_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: () {
                //Create loading state outside onPressed
                final isLoading = RxBool(false);

                return ElevatedButton(
                  onPressed: () {
                    //Validate inputs
                    if (labelController.text.isEmpty ||
                        fullAddressController.text.isEmpty ||
                        cityController.text.isEmpty ||
                        stateController.text.isEmpty ||
                        zipCodeController.text.isEmpty) {
                      Get.snackbar('Error', 'Please fill all fields');
                      return;
                    }

                    //create update address
                    final updatedAddress = Address(
                      id: address.id,
                      label: labelController.text,
                      fullAddress: fullAddressController.text,
                      city: cityController.text,
                      state: stateController.text,
                      zipCode: zipCodeController.text,
                      isDefault: isDefault.value,
                      type: selectedType.value,
                    );

                    //Set loading to true
                    isLoading.value = true;

                    //Save address
                    _controller.updateAddress(updatedAddress).then((success) {
                      //Set loading to false
                      isLoading.value = false;

                      if (success) {
                        Get.back(); //Close bottomsheet
                        Get.snackbar('Success', 'Address updated successfully');
                      } else {
                        Get.snackbar('Error', 'Failed to update address');
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                  child: Obx(
                    () => isLoading.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Update Address',
                            style: AppTextStyles.withColor(
                              AppTextStyles.buttonMedium,
                              Colors.white,
                            ),
                          ),
                  ),
                );
              }(),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showDeleteonfirmation(BuildContext context, String addressId) {
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
                () {
                  //Create loading state outside onPressed
                  final isLoading = RxBool(false);

                  return Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        //Set loading to true
                        isLoading.value = true;

                        _controller.deleteAddress(addressId).then((success) {
                          //set loading to false
                          isLoading.value = false;
                          Get.back(); // close dialog

                          if (success) {
                            Get.snackbar(
                              'Success',
                              'Address deleted succefully',
                            );
                          } else {
                            Get.snackbar('Error', 'Failed to delete address');
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(12),
                        ),
                      ),
                      child: Obx(
                        () => isLoading.value
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Delete',
                                style: AppTextStyles.withColor(
                                  AppTextStyles.buttonMedium,
                                  Colors.white,
                                ),
                              ),
                      ),
                    ),
                  );
                }(),
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

    //Text controllers for from fields
    final labelController = TextEditingController();
    final fullAddressController = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final zipCodeController = TextEditingController();

    //Address tye check box
    final selectedType = AddressType.home.obs;

    //Set as default checkbox
    final isDefault = (_controller.addresses.isEmpty).obs;

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
            TextField(
              controller: labelController,
              decoration: InputDecoration(
                labelText: 'Label (e.g. Home, Office)',
                prefixIcon: Icon(Icons.label_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 16),
            Text('Address Type', style: AppTextStyles.bodyMedium),

            SizedBox(height: 8),
            Obx(
              () => Row(
                children: [
                  _buildAddressTypeChip(
                    context,
                    'Home',
                    AddressType.home,
                    selectedType.value,
                    () => selectedType.value = AddressType.home,
                  ),
                  SizedBox(width: 8),
                  _buildAddressTypeChip(
                    context,
                    'Office',
                    AddressType.office,
                    selectedType.value,
                    () => selectedType.value = AddressType.office,
                  ),
                  SizedBox(width: 8),
                  _buildAddressTypeChip(
                    context,
                    'Other',
                    AddressType.other,
                    selectedType.value,
                    () => selectedType.value = AddressType.other,
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Obx(
              () => CheckboxListTile(
                title: Text('Set as default address'),
                value: isDefault.value,
                onChanged: (value) => isDefault.value = value ?? false,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),

            SizedBox(height: 16),

            TextField(
              controller: fullAddressController,
              decoration: InputDecoration(
                labelText: 'Full Address',
                prefixIcon: Icon(Icons.location_on_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: 'City',
                prefixIcon: Icon(Icons.location_city_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: stateController,
                    decoration: InputDecoration(
                      labelText: 'State',
                      prefixIcon: Icon(Icons.map_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: zipCodeController,
                    decoration: InputDecoration(
                      labelText: 'ZIP Code',
                      prefixIcon: Icon(Icons.pin_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: () {
                //Create loading state outside onPressed
                final isLoading = RxBool(false);

                return ElevatedButton(
                  onPressed: () {
                    //Validate inputs
                    if (labelController.text.isEmpty ||
                        fullAddressController.text.isEmpty ||
                        cityController.text.isEmpty ||
                        stateController.text.isEmpty ||
                        zipCodeController.text.isEmpty) {
                      Get.snackbar('Error', 'Please fill all fielsds');
                      return;
                    }

                    //create new address
                    final newAddress = Address(
                      id: '', //ID will be generated by repository,
                      label: labelController.text,
                      fullAddress: fullAddressController.text,
                      city: cityController.text,
                      state: stateController.text,
                      zipCode: zipCodeController.text,
                      isDefault: isDefault.value,
                      type: selectedType.value,
                    );

                    //Set loading to true
                    isLoading.value = true;

                    //Save address
                    _controller.addAddress(newAddress).then((success) {
                      //Set loading to false
                      isLoading.value = false;

                      if (success) {
                        Get.back(); //Close bottomsheet
                        Get.snackbar('Success', 'Address added successfully');
                      } else {
                        Get.snackbar('Error', 'Failed to add address');
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                  child: Obx(
                    () => isLoading.value
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Save Address',
                            style: AppTextStyles.withColor(
                              AppTextStyles.buttonMedium,
                              Colors.white,
                            ),
                          ),
                  ),
                );
              }(),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildAddressTypeChip(
    BuildContext context,
    String label,
    AddressType type,
    AddressType selectedType,
    VoidCallback onTap,
  ) {
    final isSelected = type == selectedType;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.withColor(
            AppTextStyles.bodyMedium,
            isSelected
                ? Colors.white
                : Theme.of(context).textTheme.displayLarge!.color!,
          ),
        ),
      ),
    );
  }
}
