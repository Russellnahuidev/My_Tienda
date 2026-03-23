import 'package:get/get.dart';
import 'package:my_tienda/controllers/auth_controller.dart';
import 'package:my_tienda/models/product.dart';
import 'package:my_tienda/models/wishlist_item.dart';
import 'package:my_tienda/services/wishlist_firestore_services.dart';

class WishlistController extends GetxController {
  final RxList<WishlistItem> _wishlistItems = <WishlistItem>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _hasError = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxInt _itemCount = 0.obs;

  //Get authenticad user ID
  String? get _userId {
    final authController = Get.find<AuthController>();
    return authController.user?.uid;
  }

  //Getters
  List<WishlistItem> get wishlistItems => _wishlistItems;
  bool get isLoading => _isLoading.value;
  bool get hasError => _hasError.value;
  String get errorMessage => _errorMessage.value;
  int get itemCount => _itemCount.value;
  bool get isEmpty => _wishlistItems.isEmpty;

  @override
  void onInit() {
    super.onInit();
    loadWishlistItems();
    _listenToAuthChanges();
  }

  //listen to autentication changes
  void _listenToAuthChanges() {
    final authController = Get.find<AuthController>();

    //Listen to auth changes
    ever(authController.isloggedIn.obs, (bool isLoggedIn) {
      if (isLoggedIn) {
        //User signed in, load their wishlist
        loadWishlistItems();
      } else {
        //User signed out, clear wishlist
        _wishlistItems.clear();
        _itemCount.value = 0;
        update();
      }
    });
  }

  //Load wishlist items from Firestore
  Future<void> loadWishlistItems() async {
    _isLoading.value = true;
    _hasError.value = false;

    try {
      final userId = _userId;
      if (userId == null) {
        _wishlistItems.clear();
        _itemCount.value = 0;
        _hasError.value = true;
        _errorMessage.value = "Please sign in to view your whishlist";
        return;
      }

      final items = await WishlistFirestoreServices.getUserWishlistItems(
        userId,
      );
      _wishlistItems.value = items;
      _itemCount.value = items.length;
      update(); //Notify UI to update
    } catch (e) {
      _hasError.value = true;
      _errorMessage.value = "Failed to load wishlist items. Please try again.";
      print('Error loading wishlist items: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  //Add product to wishlist
  Future<bool> addToWishlist(Product product) async {
    try {
      final userId = _userId;
      if (userId == null) {
        Get.snackbar(
          'Authenticatin Required',
          'Please sign in to add items to your wishlist',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
        return false;
      }

      final success = await WishlistFirestoreServices.addToWishlist(
        userId: userId,
        product: product,
      );

      if (success) {
        await loadWishlistItems(); //Refresh wishlist
        update(); //Notify UI
        Get.snackbar(
          'Added to Wishlist',
          '${product.name} added to your wishlist',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to add item to your wishlist',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      }

      return success;
    } catch (e) {
      print('Error adding to wishlist: $e');
      Get.snackbar(
        'Error',
        'Failed to add item to your wishlist',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return false;
    }
  }

  //Remove product from wishlist
  Future<bool> removeFromWishlist(String productId) async {
    try {
      final userId = _userId;
      if (userId == null) {
        Get.snackbar(
          'Authenticatin Required',
          'Please sign in to manage your wishlist',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
        return false;
      }

      final success = await WishlistFirestoreServices.removeFromWishlist(
        userId,
        productId,
      );

      if (success) {
        await loadWishlistItems(); //Refresh wishlist
        update(); //Notify UI
        Get.snackbar(
          'Removed from wishlist',
          'Item removed from your wishlist',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      }

      return success;
    } catch (e) {
      print('Error removing from wishlist: $e');
      return false;
    }
  }

  //Toggle product in wishlist
  Future<bool> toggleWishlist(Product product) async {
    try {
      final userId = _userId;
      if (userId == null) {
        Get.snackbar(
          'Authenticatin Required',
          'Please sign in to manege to your wishlist',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
        return false;
      }

      final isInWishlist = isProductInWishlist(product.id);

      //Update UI immediately for beter user experience
      if (isInWishlist) {
        //Optimistically remove from local list
        _wishlistItems.removeWhere((item) => item.productId == product.id);
        _itemCount.value == _wishlistItems.length;
        update(); //Notify UI
        update(['wishlist_${product.id}']); // Notify specific Product UI

        final success = await removeFromWishlist(product.id);
        if (!success) {
          //Revert if failed
          await loadWishlistItems();
        }
        return success;
      } else {
        //Optimistically add to local list (create temporary item)
        final tempItem = WishlistItem(
          id: 'temp_${DateTime.now().millisecondsSinceEpoch}',
          userId: userId,
          productId: product.id,
          product: product,
          addedAt: DateTime.now(),
        );
        _wishlistItems.insert(0, tempItem);
        _itemCount.value = _wishlistItems.length;
        update(); //Notify UI
        update(['wishlist_${product.id}']); // Notify specific Product UI

        final success = await addToWishlist(product);
        if (!success) {
          //Revert if failed
          await loadWishlistItems();
        }
        return success;
      }
    } catch (e) {
      print('Error toggling wishlist: $e');
      //Revert cchanges on error
      await loadWishlistItems();
      return false;
    }
  }

  //check if product is in wishlist
  bool isProductInWishlist(String product) {
    return _wishlistItems.any((item) => item.productId == product);
  }

  //Get whislist item for product
  WishlistItem? getWishlistItem(String productId) {
    try {
      return _wishlistItems.firstWhere((item) => item.productId == productId);
    } catch (e) {
      return null;
    }
  }

  //Clear entire wishlist
  Future<bool> clearWishlist() async {
    try {
      final userId = _userId;
      if (userId == null) {
        Get.snackbar(
          'Authenticatin Required',
          'Please sign in to manage your wishlist',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
        return false;
      }

      final success = await WishlistFirestoreServices.clearUserWishlist(userId);

      if (success) {
        _wishlistItems.clear();
        _itemCount.value = 0;
        Get.snackbar(
          'Wishlist Cleared',
          'All items removed from wishlist',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
        );
      }

      return success;
    } catch (e) {
      print('Error clearing wishlist: $e');
      return false;
    }
  }

  //Refresh wishlist
  Future<void> refreshWishlist() async {
    loadWishlistItems();
  }

  //Get products from wishlist
  List<Product> get wishlistProducts {
    return _wishlistItems.map((item) => item.product).toList();
  }
}
