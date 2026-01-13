import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/controllers/main_controller.dart';
import '../modules/main/views/main_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/splashscreen/splash_screen.dart';
import '../modules/vendor_dashboard/bindings/vendor_dashboard_binding.dart';
import '../modules/vendor_dashboard/views/vendor_dashboard_view.dart';
import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';

import '../modules/vendor_orders/bindings/vendor_orders_binding.dart';
import '../modules/vendor_orders/views/vendor_orders_view.dart';
import '../modules/vendor_settings/bindings/vendor_settings_binding.dart';
import '../modules/vendor_settings/views/vendor_settings_view.dart';
import '../modules/vendor_sales/bindings/vendor_sales_binding.dart';
import '../modules/vendor_sales/views/vendor_sales_view.dart';
import '../modules/vendor_order_details/bindings/vendor_order_details_binding.dart';
import '../modules/vendor_order_details/views/vendor_order_details_view.dart';
import '../modules/notifications/views/notification_view.dart';
import '../modules/vendor_settings/views/sub_views/vendor_store_data_view.dart';
import '../modules/vendor_settings/views/sub_views/vendor_working_hours_view.dart';
import '../modules/vendor_reports/views/vendor_reports_view.dart';
import '../modules/vendor_reports/bindings/vendor_reports_binding.dart';
import '../modules/provider_dashboard/views/provider_dashboard_view.dart';
import '../modules/provider_dashboard/bindings/provider_dashboard_binding.dart';

import '../modules/provider_dashboard/views/provider_order_details_view.dart';
import '../modules/provider_dashboard/views/provider_workflow_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PROVIDER_DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(name: "/splash", page: () => Splash_Screen()),
    GetPage(
      name: Routes.MAIN,
      page: () => const MainView(),
      binding: BindingsBuilder(() {
        Get.put(HomeController());
        Get.put(MainController());
      }),
    ),
    GetPage(
      name: _Paths.VENDOR_DASHBOARD,
      page: () => const VendorDashboardView(),
      binding: VendorDashboardBinding(),
    ),
/*
    GetPage(
      name: _Paths.MY_PRODUCTS,
      page: () => const MyProductsView(),
      binding: MyProductsBinding(),
    ),
    */
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
    ),
/*
    GetPage(
      name: _Paths.VENDOR_ORDERS,
      page: () => const VendorOrdersView(),
      binding: VendorOrdersBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_SETTINGS,
      page: () => const VendorSettingsView(),
      binding: VendorSettingsBinding(),
*/
    GetPage(
      name: _Paths.VENDOR_SALES,
      page: () => const VendorSalesView(),
      binding: VendorSalesBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_ORDER_DETAILS,
      page: () => const VendorOrderDetailsView(),
      binding: VendorOrderDetailsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationView(),
    ),
    GetPage(
      name: _Paths.VENDOR_STORE_DATA,
      page: () => const VendorStoreDataView(),
    ),
    GetPage(
      name: _Paths.VENDOR_WORKING_HOURS,
      page: () => const VendorWorkingHoursView(),
    ),
    GetPage(
      name: _Paths.VENDOR_REPORTS,
      page: () => const VendorReportsView(),
      binding: VendorReportsBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_DASHBOARD,
      page: () => const ProviderDashboardView(),
      binding: ProviderDashboardBinding(),
    ),
    GetPage(
      name: _Paths.PROVIDER_ORDER_DETAILS,
      page: () => const ProviderOrderDetailsView(),
    ),
    GetPage(
      name: _Paths.PROVIDER_WORKFLOW,
      page: () => const ProviderWorkflowView(),
    ),
  ];
}
