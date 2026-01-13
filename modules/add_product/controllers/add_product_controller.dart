import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/services/vendor_service.dart';
import '../../../routes/app_pages.dart';
import '../../vendor_dashboard/controllers/vendor_dashboard_controller.dart';

class AddProductController extends GetxController {
  // Form controllers
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final descriptionController = TextEditingController();
  final additionalSpecsController = TextEditingController();

  final selectedCategory = Rxn<String>();
  final imagePaths = <String>[].obs; // Changed to support multiple images
  final isEditing = false.obs;
  String? editingProductId;

  final categories = ['فلتر مياه', 'سخان', 'مضخة', 'صمام'].obs;

  final ImagePicker _picker = ImagePicker();
  final VendorService _vendorService = Get.find<VendorService>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is Product) {
      final Product product = Get.arguments;
      isEditing.value = true;
      editingProductId = product.id;

      nameController.text = product.name;
      priceController.text = product.price.replaceAll(RegExp(r'[^0-9.]'), '');
      imagePaths.clear();
      if (product.imageUrl.isNotEmpty) {
        imagePaths.add(product.imageUrl);
      }
      quantityController.text = product.quantity ?? '';
      descriptionController.text = product.description ?? '';
      additionalSpecsController.text = product.additionalSpecs ?? '';
      if (categories.contains(product.category)) {
        selectedCategory.value = product.category;
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    additionalSpecsController.dispose();
    super.onClose();
  }

  Future<void> publishProduct() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        imagePaths.isEmpty) {
      Get.snackbar('خطأ', 'الرجاء تعبئة جميع الحقول المطلوبة وإضافة صورة',
          backgroundColor: Colors.red.shade100, colorText: Colors.red);
      return;
    }

    if (isEditing.value) {
      final updatedProduct = Product(
        id: editingProductId!,
        name: nameController.text,
        images: imagePaths, // Updated to use list
        price: '${priceController.text} ر.ي',
        status: 'متوفر',
        isLowStock: false,
        isPublished: true,
        category: selectedCategory.value,
        quantity: quantityController.text,
        description: descriptionController.text,
        additionalSpecs: additionalSpecsController.text,
      );
      _vendorService.updateProduct(updatedProduct);
      Get.snackbar('نجاح', 'تم تحديث المنتج بنجاح',
          backgroundColor: Colors.green.shade100, colorText: Colors.green);
    } else {
      final newProduct = Product(
        id: DateTime.now().toString(),
        name: nameController.text,
        images: imagePaths, // Updated to use list
        price: '${priceController.text} ر.ي',
        status: 'متوفر', // Default status
        isLowStock: false,
        category: selectedCategory.value,
        quantity: quantityController.text,
        description: descriptionController.text,
        additionalSpecs: additionalSpecsController.text,
      );

      _vendorService.addProduct(newProduct);
      Get.snackbar('نجاح', 'تم إضافة المنتج بنجاح',
          backgroundColor: Colors.green.shade100, colorText: Colors.green);
    }

    // Navigation Logic
    await Future.delayed(const Duration(seconds: 1));

    // Check if VendorDashboardController is registered to switch tab
    if (Get.isRegistered<VendorDashboardController>()) {
      final dashboardController = Get.find<VendorDashboardController>();
      dashboardController.changeTab(1); // Switch to Products tab

      // Navigate back to the dashboard if we are in a stacked view (like Add Product)
      // This handles the case where Add Product might be pushed on top of the dashboard
      Get.until((route) => route.settings.name == Routes.VENDOR_DASHBOARD);
    } else {
      // Fallback if dashboard logic is different or checks fail
      Get.offNamed(Routes.VENDOR_DASHBOARD);
    }
  }

  Future<void> pickImage() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        for (var image in images) {
          if (!imagePaths.contains(image.path)) {
            imagePaths.add(image.path);
          }
        }
      }
    } catch (e) {
      print('Error picking images: $e');
      Get.snackbar('خطأ', 'حدث خطأ أثناء اختيار الصور');
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < imagePaths.length) {
      imagePaths.removeAt(index);
    }
  }
}
