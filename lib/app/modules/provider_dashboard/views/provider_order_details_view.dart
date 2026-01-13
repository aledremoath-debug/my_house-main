import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../../../routes/app_pages.dart';
import '../controllers/provider_dashboard_controller.dart';

class ProviderOrderDetailsView extends GetView<ProviderDashboardController> {
  const ProviderOrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Should pass order details via arguments, or default to a dummy one for now if null
    final Map<String, dynamic> order = Get.arguments ??
        {
          'clientName': 'عبدالله الراجحي',
          'location': 'شارع حدة، حي الوحدة، صنعاء، اليمن',
          'date': 'الثلاثاء، 25 أكتوبر، 2023',
          'time': 'بين 02:00 م - 04:00 م',
          'images': [
            'assets/images/product1.png',
            'assets/images/product2.png',
            'assets/images/product3.png'
          ]
        };

    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        // Rtl: Leading is Right? No, Leading is Left in LTR. In RTL it's Right.
        // Flutter handles RTL automatically for leading if not manually specified.
        // If we want Arrow on Right (RTL standard), standard BackButton works.
        // The image shows Arrow on the Right (pointing left).
        // Let's rely on Get.locale or standard AppBar.
        // Or manual leading if needed.
        title: Text(
          'تفاصيل الطلب',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.slateGrey,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Client Data
            Text(
              'بيانات العميل',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.slateGrey,
              ),
            ),
            SizedBox(height: 12.h),

            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Communication Buttons (Left side)
                  Row(
                    children: [
                      // Call Button
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: IconButton(
                          onPressed: () => controller
                              .makePhoneCall(order['phone'] ?? '967777123456'),
                          icon: Icon(Icons.phone,
                              color: const Color(0xFF4CAF50), size: 24.sp),
                          tooltip: 'اتصال بالعميل',
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // WhatsApp Button
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        child: IconButton(
                          onPressed: () => controller
                              .launchWhatsApp(order['phone'] ?? '967777123456'),
                          icon: Icon(Icons.chat,
                              color: const Color(0xFF25D366), size: 24.sp),
                          tooltip: 'واتساب',
                        ),
                      ),
                    ],
                  ),

                  // Client Info (Right side)
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            order['clientName'] ?? 'عبدالله الراجحي',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.slateGrey,
                            ),
                          ),
                          Text(
                            'العميل',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12.w),
                      CircleAvatar(
                        radius: 24.r,
                        backgroundColor: ColorManager.primary.withOpacity(0.1),
                        child: Icon(Icons.person_outline,
                            color: ColorManager.primary, size: 28.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Problem Images
            Text(
              'صور المشكلة',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.slateGrey,
              ),
            ),
            SizedBox(height: 12.h),
            _buildImagesGrid(order['images']),

            SizedBox(height: 24.h),

            // Location and Time
            Text(
              'الموقع والوقت',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.slateGrey,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  // Map Image
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r)),
                    child: Container(
                      height: 200.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F5E9), // Light Green background
                      ),
                      child: Center(
                        child: Icon(Icons.location_on,
                            color: Colors.red, size: 50.sp),
                      ),
                    ),
                  ),

                  // Location Details
                  Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      children: [
                        _buildDetailsRow(
                          Icons.location_on_outlined,
                          order['location'] ?? 'شارع حدة، حي الوحدة، صنعاء',
                          ColorManager.primary.withOpacity(0.1),
                          ColorManager.primary,
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailsRow(
                          Icons.calendar_today_outlined,
                          order['date'] ?? 'الثلاثاء، 25 أكتوبر، 2023',
                          ColorManager.primary.withOpacity(0.1),
                          ColorManager.primary,
                        ),
                        SizedBox(height: 16.h),
                        _buildDetailsRow(
                          Icons.access_time,
                          order['time'] ?? 'بين 02:00 م - 04:00 م',
                          ColorManager.primary.withOpacity(0.1),
                          ColorManager.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.acceptOrder('dummy_id');
                  Get.toNamed(Routes.PROVIDER_WORKFLOW, arguments: {
                    'id': '12345',
                    'title': 'تركيب وحدة تكييف جديدة',
                    'clientName': 'عبدالله الأحمد',
                    'date': '12 أغسطس',
                    'time': '10:00 صباحاً',
                    'currentStep': 1,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'قبول الطلب',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => controller.rejectOrder('dummy_id'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFEBEE), // Light Red
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'رفض الطلب',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => controller
                        .launchWhatsApp(order['phone'] ?? '967777123456'),
                    icon: Icon(Icons.chat,
                        color: const Color(0xFF25D366), size: 18.sp),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE8F5E9),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      elevation: 0,
                    ),
                    label: Text(
                      'تواصل مع العميل',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF25D366),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsRow(
      IconData icon, String text, Color bgColor, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Text (Right) - Actually in LTR row, we place Text first then Icon for RTL look?
        // Wait, Row starts from Left.
        // We want: [Icon] ...space... [Text] (LTR) -> NO, RTL usually is [Text] ...space... [Icon]
        // But the image shows: [Text aligned right] [Icon Circle aligned right edge]
        // Image structure:
        // [                       Text ] [Icon]
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorManager.slateGrey,
              height: 1.4,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 20.sp),
        ),
      ],
    );
  }

  Widget _buildImagesGrid(List<dynamic>? images) {
    return Row(
      children: [
        // Large Image Left (or Right in RTL?)
        // Image 1 shows Large Image Left, two small images Right.
        // Let's stick to that layout as per visual.
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              height: 150.h,
              color: Colors.grey.shade200,
              child: Image.asset(
                'assets/images/product1.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.image, size: 40.sp, color: Colors.grey),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Two Smaller Images Right
        Expanded(
          flex: 1,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  height: 69.h,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: Image.asset(
                    'assets/images/product2.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.image, size: 30.sp, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Container(
                  height: 69.h,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: Image.asset(
                    'assets/images/product3.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Icon(Icons.image, size: 30.sp, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
