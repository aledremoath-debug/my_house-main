import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/services/vendor_service.dart';
import '../../../routes/app_pages.dart';

class VendorDashboardController extends GetxController {
  final VendorService _vendorService = Get.find<VendorService>();

  RxString get storeLogo => _vendorService.storeLogo;
  RxString get storeName => _vendorService.storeName;

  // Dummy data for stats
  final productCount = 128.obs;
  final newOrders = 16.obs;
  final completedOrders = 72.obs;
  final totalSales = 15230.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onAddProduct() {
    Get.toNamed(Routes.ADD_PRODUCT);
  }

  final tabIndex = 0.obs;

  void changeTab(int index) {
    tabIndex.value = index;
  }

  void onMyProducts() {
    changeTab(1);
  }

  void showProfileDialog() {
    Get.dialog(
      Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'صورة الملف الشخصي',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              CircleAvatar(
                radius: 60.r,
                backgroundImage: AssetImage('assets/images/user_avatar.png'),
                backgroundColor: Colors.grey[200],
              ),
              SizedBox(height: 20.h),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement image picker
                  _pickImage();
                },
                icon: Icon(Icons.camera_alt),
                label: Text('تغيير الصورة'),
                style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: () => Get.back(),
                child: Text('إغلاق', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    // Basic implementation for image picker
    // In a real app, you would use ImagePicker and update a reactive variable for the image
    Get.back();
    Get.snackbar(
      'تنبيه',
      'تم تغيير الصورة بنجاح (محاكاة)',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
