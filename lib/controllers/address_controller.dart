import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_tienda/features/shippin_address/models/address.dart';
import 'package:my_tienda/services/address_firebase_service.dart';

class AddressController extends GetxController {
  final AddressFirebaseService _addressFirebaseService =
      AddressFirebaseService();

  //Observable variables
  final RxList<Address> _addresses = <Address>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _hasError = false.obs;
  final RxString _errorMessage = ''.obs;

  //Getters
  List<Address> get addresses => _addresses;
  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  String get errorMessage => _errorMessage.value;

  //Clear addresses (used when user logs out)
  void clearAddresses() {
    _addresses.clear();

    _hasError.value = false;
    _errorMessage.value = '';
    update(); //Notify listeners
  }

  //Load all addresses from Firestore
  Future<void> loadAddresses() async {
    _isLoading.value = true;
    _hasError.value = false;
    _errorMessage.value = '';

    try {
      // validate user
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("User not authenticated - skipping address load");
        _addresses.clear();
        return;
      }
      //Load addresses from Firestore
      final addresses = await _addressFirebaseService.getAddresses();
      _addresses.assignAll(addresses);
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = 'Failed to load addresses: $e';
    } finally {
      _isLoading.value = false;
      update(); //Notify listeners
    }
  }

  //Add a new address
  Future<bool> addAddress(Address address) async {
    _isLoading.value = true;
    update();

    try {
      final success = await _addressFirebaseService.addAddress(address);
      if (success) {
        await loadAddresses(); //Refresh the list
        return true;
      }
      return false;
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = 'Failed to add address: $e';
      update();
      return false;
    } finally {
      _isLoading.value = false;
      update(); //Notify listeners
    }
  }

  //Update an existing address
  Future<bool> updateAddress(Address address) async {
    _isLoading.value = true;
    update();

    try {
      final success = await _addressFirebaseService.updateAddress(address);
      if (success) {
        await loadAddresses(); //Refresh the list
        return true;
      }
      return false;
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = 'Failed to update address: $e';
      update();
      return false;
    } finally {
      _isLoading.value = false;
      update(); //Notify listeners
    }
  }

  //Delete an address
  Future<bool> deleteAddress(String addressId) async {
    _isLoading.value = true;
    update();

    try {
      final success = await _addressFirebaseService.deleteAddress(addressId);
      if (success) {
        await loadAddresses(); //Refresh the list
        return true;
      }
      return false;
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = 'Failed to delete address: $e';
      update();
      return false;
    } finally {
      _isLoading.value = false;
      update(); //Notify listeners
    }
  }

  //Set an address as default
  Future<bool> setDefaultAddress(String addressId) async {
    _isLoading.value = true;
    update();

    try {
      final success = await _addressFirebaseService.setDefaultAddress(
        addressId,
      );
      if (success) {
        await loadAddresses(); //Refresh the list
        return true;
      }
      return false;
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = 'Failed to set default address: $e';
      update();
      return false;
    } finally {
      _isLoading.value = false;
      update(); //Notify listeners
    }
  }
}
