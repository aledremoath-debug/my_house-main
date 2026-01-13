import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/provider_dashboard_controller.dart';

class ProviderOrdersView extends GetView<ProviderDashboardController> {
  const ProviderOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorManager.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          // Leading Space to match Dashboard symmetry
          leading: SizedBox(width: 28.sp),
          // Notification Icon (Left in RTL)
          actions: [
            GestureDetector(
              onTap: () => controller.goToNotifications(),
              child: Icon(Icons.notifications_none,
                  color: const Color(0xFF1E88E5), size: 28.sp),
            ),
            SizedBox(width: 16.w), // Right padding to match Dashboard edge
          ],
          title: Text(
            'طلبات الخدمات',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: ColorManager.slateGrey,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: Container(
              color: Colors.white,
              child: TabBar(
                labelColor: ColorManager.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: ColorManager.primary,
                indicatorWeight: 3,
                labelStyle:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: 'جديد'),
                  Tab(text: 'قيد التنفيذ'),
                  Tab(text: 'مكتمل'),
                  Tab(text: 'مرفوض'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Obx(() => _buildOrdersList(controller.newOrders)),
            Obx(() => _buildOrdersList(controller.inProgressOrders)),
            Obx(() => _buildOrdersList(controller.completedOrdersList)),
            Obx(() => _buildOrdersList(controller.rejectedOrders)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined,
                size: 60.sp, color: Colors.grey.shade300),
            SizedBox(height: 16.h),
            Text(
              'لا توجد طلبات في هذه القائمة',
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.all(20.r),
      itemCount: orders.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) => _buildOrderCard(orders[index]),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
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
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Service Icon (Left side in LTR, Right side in RTL - Image shows it on Left relative to text? No, image shows it on one side.)
                // Let's stick to standard RTL: Image Right, Text Left.
                // UNLESS the image uploaded_image_2 shows clearly: Icon Circle is on the RIGHT side. Text is on the LEFT side?
                // Wait, Arabic text reads right to left.
                // Image 2 shows:
                // [Text Details]         [Icon Circle]
                // So text is on the Right, Icon is on the Left? No.
                // If I assume the layout is RTL: Icon Circle (Left) -> Text (Right).
                // Let's look at crop 2 again.
                // Icon (Cyan circle with plug) is on the LEFT of the text block? Or Right?
                // Actually, looking at the layout, it seems the Icon is on the LEFT.
                // And text is aligned to the RIGHT.
                // Let's implement Icon on Left, Text Expanded next to it.
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    order['icon'] ?? Icons.electrical_services,
                    color: ColorManager.primary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                // Text Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        order['category'] ?? 'كهرباء',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        order['title'] ?? 'تركيب إضاءة سقف جديدة',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.slateGrey,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(height: 12.h),

                      // Divider dashed line? Image has dashed line under title?
                      // Image shows a dashed line separating Title section from details.
                      Divider(
                        color: Colors.grey.shade200,
                        thickness: 1,
                        height: 24.h,
                      ),

                      _buildInfoRow(Icons.person_outline,
                          'العميل: ${order['clientName']}'),
                      SizedBox(height: 8.h),
                      _buildInfoRow(Icons.access_time,
                          '${order['date']}, ${order['time']}'),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                          Icons.location_on_outlined, order['location'] ?? ''),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h)
                .copyWith(top: 0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.goToOrderDetails(order),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'عرض التفاصيل',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 13.sp,
            color: ColorManager.slateGrey,
          ),
        ),
        SizedBox(width: 8.w),
        Icon(icon, size: 16.sp, color: Colors.grey),
      ],
    );
  }
}
