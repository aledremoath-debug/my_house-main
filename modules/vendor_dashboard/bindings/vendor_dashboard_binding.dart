import 'package:get/get.dart';

import '../controllers/vendor_dashboard_controller.dart';
import '../../my_products/controllers/my_products_controller.dart';
import '../../vendor_orders/controllers/vendor_orders_controller.dart';
import '../../vendor_settings/controllers/vendor_settings_controller.dart';

class VendorDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorDashboardController>(
      () => VendorDashboardController(),
    );
    Get.lazyPut<MyProductsController>(
      () => MyProductsController(),
    );
    Get.lazyPut<VendorOrdersController>(
      () => VendorOrdersController(),
    );
    Get.lazyPut<VendorSettingsController>(
      () => VendorSettingsController(),
    );
  }
}
