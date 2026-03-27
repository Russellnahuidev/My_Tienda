import 'package:get/get.dart';
import 'package:my_tienda/controllers/product_controller.dart';

class NavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    //Listen to changes in the current intex
    ever(currentIndex, (index) {
      //Reset filters when navigation to any tab other ShoppingScreen (index 1)
      if (index != 1) {
        final productController = Get.find<ProductController>();
        productController.resetFilters();
      }
    });
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
