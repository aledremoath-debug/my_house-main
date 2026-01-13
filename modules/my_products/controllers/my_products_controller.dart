import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../data/services/vendor_service.dart';
import '../views/product_details_view.dart';

class MyProductsController extends GetxController {
  final VendorService _vendorService = Get.find<VendorService>();

  RxList<Product> get products => _vendorService.products;
  final filteredProducts = <Product>[].obs;
  final isSearching = false.obs;
  final searchText = ''.obs;
  final isGridView = true.obs; // Default to Grid View
  final currentImageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize filtered list
    filteredProducts.value = _vendorService.products;

    // Listen to changes in products or search text
    ever(_vendorService.products, (_) => _filterProducts());
    debounce(searchText, (_) => _filterProducts(),
        time: const Duration(milliseconds: 300));
  }

  void toggleViewMode() {
    isGridView.toggle();
  }

  void _filterProducts() {
    if (searchText.value.isEmpty) {
      filteredProducts.value = _vendorService.products;
    } else {
      filteredProducts.value = _vendorService.products
          .where((p) => p.name.contains(searchText.value))
          .toList();
    }
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchText.value = '';
      filteredProducts.value = _vendorService.products;
    }
  }

  void updateSearch(String val) {
    searchText.value = val;
  }

  void showProductDetails(Product product) {
    currentImageIndex.value = 0; // Reset index
    Get.to(() => ProductDetailsView(product: product));
  }

  void onAddProduct() {
    Get.toNamed(Routes.ADD_PRODUCT);
  }

  void deleteProduct(Product product, {Function? onSuccess}) {
    Get.defaultDialog(
      title: 'حذف المنتج',
      middleText: 'هل أنت متأكد أنك تريد حذف هذا المنتج؟',
      textConfirm: 'نعم',
      textCancel: 'لا',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        _vendorService.deleteProduct(product.id);
        Get.back();
        if (onSuccess != null) onSuccess();
      },
    );
  }

  void toggleProductStatus(Product product) {
    _vendorService.togglePublishStatus(product.id);
    Get.snackbar(
      product.isPublished ? 'تم إخفاء المنتج' : 'تم إظهار المنتج',
      product.isPublished
          ? 'لن يظهر هذا المنتج للعملاء بعد الآن'
          : 'أصبح المنتج متاحاً للعرض للعملاء',
      backgroundColor: Colors.blue.shade100,
      colorText: Colors.blue.shade900,
    );
  }

  void onEditProduct(Product product) {
    Get.toNamed(Routes.ADD_PRODUCT, arguments: product);
  }

  void updateProductQuantity(Product product, String newQuantity) {
    _vendorService.updateProductQuantity(product.id, newQuantity);
    Get.snackbar(
      'تم التحديث',
      'تم تحديث كمية المنتج بنجاح',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green,
    );
  }
}
