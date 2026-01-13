import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../../../routes/app_pages.dart';
import '../controllers/vendor_dashboard_controller.dart';

class VendorHomeView extends GetView<VendorDashboardController> {
  const VendorHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),
            SizedBox(height: 30.h),

            // Welcome Stats
            Obx(() => Text(
                  'أهلاً بك، ${controller.storeName.value}',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                )),
            SizedBox(height: 20.h),

            // Stats Grid
            _buildStatsGrid(),
            SizedBox(height: 30.h),

            // Add Product Button
            _buildAddProductButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() {
          final logoPath = controller.storeLogo.value;
          return CircleAvatar(
            radius: 25.r,
            backgroundImage: logoPath.isNotEmpty
                ? FileImage(File(logoPath))
                : const AssetImage('assets/images/user_avatar.png')
                    as ImageProvider,
            backgroundColor: Colors.grey[300],
          );
        }),
        Text(
          'لوحة التحكم',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.slateGrey,
          ),
        ),
        IconButton(
            onPressed: () {
              Get.toNamed(Routes.NOTIFICATIONS);
            },
            icon: Icon(Icons.notifications_none,
                size: 28.sp, color: ColorManager.slateGrey)),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 15.w,
      mainAxisSpacing: 15.h,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.4,
      children: [
        _buildStatCard(
            title: 'المنتجات',
            value: controller.productCount.toString(),
            icon: Icons.inventory_2_outlined,
            color: ColorManager.primary),
        _buildStatCard(
            title: 'الطلبات الجديدة',
            value: controller.newOrders.toString(),
            icon: Icons.new_releases_outlined,
            color: ColorManager.primary),
        _buildStatCard(
            title: 'إجمالي المبيعات',
            value: '${controller.totalSales} د.أ',
            icon: Icons.monetization_on_outlined,
            color: ColorManager.primary),
        _buildStatCard(
            title: 'الطلبات المكتملة',
            value: controller.completedOrders.toString(),
            icon: Icons.check_circle_outline,
            color: ColorManager.primary),
      ],
    );
  }

  Widget _buildStatCard(
      {required String title,
      required String value,
      required IconData icon,
      required Color color}) {
    return Container(
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24.sp),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddProductButton() {
    return GestureDetector(
      onTap: controller.onAddProduct,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18.h),
        decoration: BoxDecoration(
          color: ColorManager.secondary,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.secondary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline, color: Colors.white, size: 24.sp),
            SizedBox(width: 10.w),
            Text(
              'أضف منتج جديد',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
