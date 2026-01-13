import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../../../routes/app_pages.dart';
import '../controllers/vendor_settings_controller.dart';

class VendorSettingsView extends GetView<VendorSettingsController> {
  const VendorSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false, // Removed back button
          title: Text(
            'إعدادات التاجر',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: ColorManager.slateGrey,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5))
                      ]),
                  child: Column(
                    children: [
                      _buildSettingItem(
                        icon: Icons.storefront,
                        title: 'بيانات المتجر',
                        subtitle: 'تعديل اسم المتجر، الشعار، والوصف',
                        iconColor: Colors.blue.shade100,
                        iconColorSymbol: Colors.blue,
                        onTap: () => Get.toNamed(Routes.VENDOR_STORE_DATA),
                      ),
                      Divider(height: 1),
                      _buildSettingItem(
                        icon: Icons.access_time,
                        title: 'ساعات العمل',
                        iconColor: Colors.cyan.shade100,
                        iconColorSymbol: Colors.cyan,
                        onTap: () => Get.toNamed(Routes.VENDOR_WORKING_HOURS),
                      ),
                      Divider(height: 1),
                      _buildSettingItem(
                        icon: Icons.bar_chart,
                        title: 'التقارير',
                        iconColor: Colors.purple.shade100,
                        iconColorSymbol: Colors.purple,
                        onTap: () => Get.toNamed(Routes.VENDOR_REPORTS),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: controller.onLogout,
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red.shade50,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r))),
                    icon: Icon(Icons.logout, color: Colors.red),
                    label: Text(
                      'تسجيل الخروج',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
      {required IconData icon,
      required String title,
      String? subtitle,
      required Color iconColor,
      required Color iconColorSymbol,
      required VoidCallback onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      leading: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(color: iconColor, shape: BoxShape.circle),
        child: Icon(icon, color: iconColorSymbol),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          color: ColorManager.slateGrey,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            )
          : null,
      trailing: Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey),
      onTap: onTap,
    );
  }
}
