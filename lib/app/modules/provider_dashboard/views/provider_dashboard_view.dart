import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/provider_dashboard_controller.dart';
import 'provider_home_view.dart';
import 'provider_orders_view.dart';
import 'provider_my_reviews_view.dart';
import 'provider_profile_view.dart';

class ProviderDashboardView extends GetView<ProviderDashboardController> {
  const ProviderDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SafeArea(
        child: Obx(() => IndexedStack(
              index:
                  controller.tabIndex.value > 3 ? 0 : controller.tabIndex.value,
              children: const [
                ProviderHomeView(),
                ProviderOrdersView(),
                ProviderMyReviewsView(),
                ProviderProfileView(),
              ],
            )),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex:
              controller.tabIndex.value > 3 ? 0 : controller.tabIndex.value,
          onTap: controller.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              activeIcon: Icon(Icons.format_list_bulleted),
              label: 'الطلبات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_outline),
              activeIcon: Icon(Icons.star),
              label: 'تقييماتي',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'حسابي',
            ),
          ],
        ));
  }
}
