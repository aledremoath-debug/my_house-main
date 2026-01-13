import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/vendor_dashboard_controller.dart';
import '../../my_products/views/my_products_view.dart';
import '../../vendor_orders/views/vendor_orders_view.dart';
import '../../vendor_settings/views/vendor_settings_view.dart';
import 'vendor_home_view.dart';

class VendorDashboardView extends GetView<VendorDashboardController> {
  const VendorDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SafeArea(
        child: Obx(() => IndexedStack(
              index: controller.tabIndex.value,
              children: [
                const VendorHomeView(),
                const MyProductsView(),
                const VendorOrdersView(),
                const VendorSettingsView(),
              ],
            )),
      ),
      floatingActionButton: Obx(() => controller.tabIndex.value == 1
          ? FloatingActionButton(
              onPressed: controller.onAddProduct,
              backgroundColor: ColorManager.blue,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : const SizedBox.shrink()),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Header, Stats, etc are now in VendorHomeView

  Widget _buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorManager.secondary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory),
              label: 'المنتجات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long),
              label: 'الطلبات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'الملف الشخصي',
            ),
          ],
        ));
  }
}
