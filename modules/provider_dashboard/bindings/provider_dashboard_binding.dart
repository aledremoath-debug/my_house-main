import 'package:get/get.dart';
import '../controllers/provider_dashboard_controller.dart';

class ProviderDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProviderDashboardController>(
      () => ProviderDashboardController(),
    );
  }
}
