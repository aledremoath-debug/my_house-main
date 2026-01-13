import 'package:get/get.dart';

import '../controllers/vendor_reports_controller.dart';

class VendorReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorReportsController>(
      () => VendorReportsController(),
    );
  }
}
