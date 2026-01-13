import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/provider_dashboard_controller.dart';

class ProviderProfileView extends GetView<ProviderDashboardController> {
  const ProviderProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            // Header
            _buildHeader(),
            SizedBox(height: 20.h),

            // Profile Info (Avatar + Name)
            _buildProfileInfo(),
            SizedBox(height: 20.h),

            // Rating Stats Card
            _buildRatingStatsCard(),
            SizedBox(height: 20.h),

            // Settings Menu
            _buildSettingsMenu(),
            SizedBox(height: 30.h),

            // Logout Button
            _buildLogoutButton(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 40.w),
        Text(
          'حسابي',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.slateGrey,
          ),
        ),
        SizedBox(width: 40.w),
      ],
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.15), // Uses Primary
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.person, size: 50.sp, color: ColorManager.primary),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Name
          Obx(() => Text(
                controller.providerName.value,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.slateGrey,
                ),
              )),
          SizedBox(height: 4.h),

          // Title
          Obx(() => Text(
                controller.providerTitle.value,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              )),
          SizedBox(height: 8.h),

          // Location
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(
                    controller.providerLocation.value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  )),
              SizedBox(width: 4.w),
              Icon(
                Icons.location_on_outlined,
                size: 18.sp,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStatsCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Stats Bars (Left side)
          Expanded(
            child: Column(
              children: [
                _buildRatingBar(5, 70),
                SizedBox(height: 8.h),
                _buildRatingBar(4, 20),
                SizedBox(height: 8.h),
                _buildRatingBar(3, 5),
                SizedBox(height: 8.h),
                _buildRatingBar(2, 3),
                SizedBox(height: 8.h),
                _buildRatingBar(1, 2),
              ],
            ),
          ),

          SizedBox(width: 20.w),

          // Big Score (Right side)
          Column(
            children: [
              Obx(() => Text(
                    '${controller.averageRating.value}',
                    style: TextStyle(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.slateGrey,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    5,
                    (index) => Icon(
                          Icons.star,
                          color: ColorManager.primary, // Uses Primary
                          size: 18.sp,
                        )),
              ),
              SizedBox(height: 4.h),
              Obx(() => Text(
                    '${controller.totalReviews.value} تقييم',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int star, int percent) {
    return Row(
      children: [
        // Percentage Text
        SizedBox(
          width: 30.w,
          child: Text(
            '$percent%',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ),
        SizedBox(width: 8.w),

        // Bar
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percent / 100,
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: ColorManager.primary, // Uses Primary
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 8.w),

        // Star Number
        Text(
          '$star',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildSettingsMenu() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          _buildMenuItem(Icons.help_outline, 'المساعدة والدعم'),
          _buildDivider(),
          _buildMenuItem(Icons.info_outline, 'عن التطبيق'),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: ColorManager.primary.withOpacity(0.1), // Uses Primary
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: ColorManager.primary, size: 22.sp),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: ColorManager.slateGrey,
        ),
      ),
      trailing: Icon(
        Icons.arrow_back_ios_new,
        size: 16.sp,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
        height: 1,
        thickness: 1,
        color: Colors.grey.shade100,
        indent: 20.w,
        endIndent: 20.w);
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: controller.logout,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'تسجيل الخروج',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.logout, color: Colors.red, size: 24.sp),
        ],
      ),
    );
  }
}
