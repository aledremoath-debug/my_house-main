import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../views/sub_views/vendor_store_data_view.dart';
import '../../../data/services/vendor_service.dart';
import '../../../routes/app_pages.dart';

class WorkingDay {
  final String dayName;
  bool isOpen;
  String openTime;
  String closeTime;

  WorkingDay({
    required this.dayName,
    this.isOpen = true,
    this.openTime = '09:00 ص',
    this.closeTime = '10:00 م',
  });
}

class VendorSettingsController extends GetxController {
  final VendorService _vendorService = Get.find<VendorService>();
  final workingDays = <WorkingDay>[].obs;

  // Store Data
  late TextEditingController storeNameController;
  late TextEditingController storeDescController;

  RxString get storeLogo => _vendorService.storeLogo;
  RxString get storeBanner => _vendorService.storeBanner;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _initWorkingDays();
    storeNameController =
        TextEditingController(text: _vendorService.storeName.value);
    storeDescController =
        TextEditingController(text: 'نقدم أفضل المنتجات بأفضل الأسعار');
  }

  Future<void> pickStoreImage(bool isLogo) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        if (isLogo) {
          _vendorService.storeLogo.value = image.path;
        } else {
          _vendorService.storeBanner.value = image.path;
        }
      }
    } catch (e) {
      Get.snackbar('خطأ', 'فشل اختيار الصورة');
    }
  }

  void saveStoreData() {
    _vendorService.storeName.value = storeNameController.text;
    Get.snackbar(
      'تم الحفظ',
      'تم تحديث بيانات المتجر بنجاح',
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green,
    );
    Get.back();
  }

  void _initWorkingDays() {
    final days = [
      'السبت',
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة'
    ];
    workingDays.assignAll(days.map((day) => WorkingDay(dayName: day)).toList());
  }

  void toggleDay(int index, bool val) {
    workingDays[index].isOpen = val;
    workingDays.refresh();
  }

  void updateTime(BuildContext context, int index, bool isOpenTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final localizations = MaterialLocalizations.of(context);
      final formattedTime =
          localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: false);

      // Replace English AM/PM with Arabic if needed, or leave as is if system is Arabic
      // For simplicity, we assume system locale handles it or we accept generic format

      if (isOpenTime) {
        workingDays[index].openTime = formattedTime;
      } else {
        workingDays[index].closeTime = formattedTime;
      }
      workingDays.refresh();
    }
  }

  void saveWorkingHours() {
    // Here you would send data to API
    Get.snackbar(
      'تم الحفظ',
      'تم تحديث ساعات العمل بنجاح',
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green,
    );
    // Navigate to Store Data View as requested
    Get.off(() => const VendorStoreDataView());
  }

  void onLogout() {
    Get.offAllNamed(Routes.LOGIN); // Or appropriate route
  }
}
