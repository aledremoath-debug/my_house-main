import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/provider_dashboard_controller.dart';

class ProviderHomeView extends GetView<ProviderDashboardController> {
  const ProviderHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _buildHeader(),
            SizedBox(height: 20.h),

            // Availability Toggle Card
            _buildAvailabilityCard(),
            SizedBox(height: 12.h),

            // Completed Orders Card
            _buildCompletedOrdersCard(),
            SizedBox(height: 12.h),

            // Average Rating Card
            _buildRatingCard(),
            SizedBox(height: 24.h),

            // Latest Orders Section
            _buildLatestOrdersSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Placeholder instead of Menu Icon to keep title centered if needed, or just remove
        SizedBox(width: 28.sp),

        // Title (Center)
        Text(
          'لوحة التحكم',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.slateGrey,
          ),
        ),

        // Notification Icon (Left in RTL - so Last Child)
        GestureDetector(
          onTap: () => controller.goToNotifications(),
          child: Icon(
            Icons.notifications_none,
            size: 28.sp,
            color: const Color(0xFF1E88E5), // Blue shade
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilityCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      // Use Row to put Text (Right) and Switch (Left)
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text Column (Right in RTL)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                    controller.isAvailable.value
                        ? 'أنت الآن متاح'
                        : 'أنت غير متاح',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.slateGrey,
                    ),
                  )),
              SizedBox(height: 4.h),
              Obx(() => Text(
                    controller.isAvailable.value
                        ? 'يمكنك استقبال طلبات جديدة.'
                        : 'لن تستقبل طلبات جديدة.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  )),
            ],
          ),

          // Toggle Switch (Left in RTL)
          Obx(() => Transform.scale(
                scale: 1.2,
                child: Switch(
                  value: controller.isAvailable.value,
                  onChanged: (value) => controller.toggleAvailability(),
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF2196F3), // Blue
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey.shade300,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildCompletedOrdersCard() {
    return Container(
      width: double.infinity,
      height: 120.h, // Same Fixed height
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'الطلبات المكتملة',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Obx(() => Text(
                '${controller.completedOrders.value}',
                style: TextStyle(
                  fontSize: 28.sp, // Same font size as Earnings
                  fontWeight: FontWeight.bold,
                  color: ColorManager.slateGrey,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildRatingCard() {
    return Container(
      width: double.infinity,
      height: 120.h, // Same Fixed height
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'متوسط التقييم',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.star,
                color: const Color(0xFFF1C40F),
                size: 28.sp,
              ),
              SizedBox(width: 8.w),
              Obx(() => Text(
                    '${controller.averageRating.value}',
                    style: TextStyle(
                      fontSize: 28.sp, // Same font size
                      fontWeight: FontWeight.bold,
                      color: ColorManager.slateGrey,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLatestOrdersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'أحدث الطلبات',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.slateGrey,
          ),
        ),
        SizedBox(height: 16.h),

        // Orders List
        Obx(() => controller.latestOrdersOverview.isEmpty
            ? _buildEmptyOrdersState()
            : Column(
                children: controller.latestOrdersOverview
                    .map((order) => _buildOrderCard(order))
                    .toList(),
              )),
      ],
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return GestureDetector(
      onTap: () => controller.goToOrderDetails(order),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image (Right in RTL - First child)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    width: 60.w,
                    height: 60.h,
                    color: Colors.grey.shade200,
                    child: order['image'] != null
                        ? Image.asset(
                            order['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.image,
                                size: 30.sp,
                                color: Colors.grey),
                          )
                        : Icon(Icons.image, size: 30.sp, color: Colors.grey),
                  ),
                ),
                SizedBox(width: 12.w),

                // Order Details (Left in RTL - Second child)
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.end, // Align text to Right
                    children: [
                      // Status Text
                      Text(
                        order['status'] ?? 'بانتظار الموافقة',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4.h),

                      // Service Name
                      Text(
                        order['title'] ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.slateGrey,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 4.h),

                      // Location and Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${order['location'] ?? ''} - ${order['time'] ?? ''}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(width: 4.w),
                          Icon(Icons.location_on_outlined,
                              size: 14.sp, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.acceptOrder(order['id']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      elevation: 0,
                    ),
                    child: Text(
                      'قبول',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.rejectOrder(order['id']),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFFFFEBEE), // Light Red to match Details View
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      elevation: 0,
                    ),
                    child: Text(
                      'رفض',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyOrdersState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(40.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: const Color(0xFFE1F5FE), // Light Blue bg
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inbox_outlined,
              size: 40.sp,
              color: const Color(0xFF29B6F6), // Light Blue icon
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'لا توجد طلبات جديدة',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: ColorManager.slateGrey,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'سيتم إعلامك عند وصول طلب جديد.',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
