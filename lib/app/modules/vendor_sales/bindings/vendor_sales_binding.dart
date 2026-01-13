import 'package:get/get.dart';

import '../controllers/vendor_sales_controller.dart';

class VendorSalesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorSalesController>(
      () => VendorSalesController(),
    );
  }
}
