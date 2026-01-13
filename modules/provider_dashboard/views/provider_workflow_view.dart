import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/provider_dashboard_controller.dart';

class ProviderWorkflowView extends GetView<ProviderDashboardController> {
  const ProviderWorkflowView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get order data from arguments or use dummy data
    final Map<String, dynamic> order = Get.arguments ??
        {
          'id': '12345',
          'title': 'تركيب وحدة تكييف جديدة',
          'clientName': 'عبدالله الأحمد',
          'date': '12 أغسطس',
          'time': '10:00 صباحاً',
          'currentStep': 1, // 0: accepted, 1: in_progress, 2: completed
        };

    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  children: [
                    // Order Header Card
                    _buildOrderHeaderCard(order),
                    SizedBox(height: 30.h),

                    // Workflow Timeline
                    _buildWorkflowTimeline(order),
                  ],
                ),
              ),
            ),

            // Bottom Action Buttons
            _buildBottomActions(order),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Placeholder for alignment
          SizedBox(width: 40.w),

          // Title
          Text(
            'سير العمل',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorManager.slateGrey,
            ),
          ),

          // Back Arrow
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_forward,
              size: 24.sp,
              color: ColorManager.slateGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderHeaderCard(Map<String, dynamic> order) {
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
          // Order Image/Banner with gradient
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: Container(
              height: 140.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorManager.primary,
                    ColorManager.primary.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),

          // Order Details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              children: [
                // Order Number
                Text(
                  'رقم الطلب: #${order['id']}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8.h),

                // Order Title
                Text(
                  order['title'] ?? 'تفاصيل الطلب',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.slateGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),

                // Client Info Row
                _buildInfoRow(
                  Icons.person_outline,
                  'اسم العميل: ${order['clientName']}',
                ),
                SizedBox(height: 12.h),

                // Date and Time Row
                _buildInfoRow(
                  Icons.calendar_today_outlined,
                  'الموعد: ${order['date']}، ${order['time']}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: ColorManager.slateGrey,
          ),
        ),
        SizedBox(width: 8.w),
        Icon(icon, size: 18.sp, color: Colors.grey.shade600),
      ],
    );
  }

  Widget _buildWorkflowTimeline(Map<String, dynamic> order) {
    final int currentStep = order['currentStep'] ?? 1;

    return Column(
      children: [
        // Step 1: Accepted (تم القبول)
        _buildTimelineStep(
          title: 'تم القبول',
          description: 'لقد قبلت هذا الطلب بنجاح.',
          icon: Icons.check,
          stepIndex: 0,
          currentStep: currentStep,
          isFirst: true,
          isLast: false,
          activeColor: const Color(0xFF4CAF50), // Green
        ),

        // Step 2: In Progress (قيد التنفيذ)
        _buildTimelineStep(
          title: 'قيد التنفيذ',
          description: 'هذه هي المرحلة الحالية.',
          icon: Icons.sync,
          stepIndex: 1,
          currentStep: currentStep,
          isFirst: false,
          isLast: false,
          activeColor: ColorManager.primary,
        ),

        // Step 3: Completed (مكتمل)
        _buildTimelineStep(
          title: 'مكتمل',
          description: '',
          icon: Icons.flag_outlined,
          stepIndex: 2,
          currentStep: currentStep,
          isFirst: false,
          isLast: true,
          activeColor: ColorManager.primary,
        ),
      ],
    );
  }

  Widget _buildTimelineStep({
    required String title,
    required String description,
    required IconData icon,
    required int stepIndex,
    required int currentStep,
    required bool isFirst,
    required bool isLast,
    required Color activeColor,
  }) {
    final bool isCompleted = stepIndex < currentStep;
    final bool isActive = stepIndex == currentStep;

    Color getIconBackgroundColor() {
      if (isCompleted) {
        return stepIndex == 0 ? const Color(0xFF4CAF50) : ColorManager.primary;
      } else if (isActive) {
        return ColorManager.primary;
      } else {
        return Colors.grey.shade200;
      }
    }

    Color getIconColor() {
      if (isCompleted || isActive) {
        return Colors.white;
      } else {
        return Colors.grey.shade400;
      }
    }

    Color getTitleColor() {
      if (isCompleted) {
        return stepIndex == 0 ? const Color(0xFF4CAF50) : ColorManager.primary;
      } else if (isActive) {
        return ColorManager.primary;
      } else {
        return Colors.grey.shade500;
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side: Timeline line and Icon
        SizedBox(
          width: 50.w,
          child: Column(
            children: [
              // Step Icon
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: getIconBackgroundColor(),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 20.sp,
                  color: getIconColor(),
                ),
              ),

              // Bottom Line (if not last)
              if (!isLast)
                Container(
                  width: 2.w,
                  height: 50.h,
                  color: isCompleted || isActive
                      ? ColorManager.primary.withOpacity(0.3)
                      : Colors.grey.shade200,
                ),
            ],
          ),
        ),

        // Right side: Step Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 8.h, right: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: getTitleColor(),
                  ),
                ),
                if (description.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
                SizedBox(height: isLast ? 0 : 30.h),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(Map<String, dynamic> order) {
    final int currentStep = order['currentStep'] ?? 1;
    final bool isCompleted = currentStep >= 2;

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Secondary Action Buttons Row
          Row(
            children: [
              // Add Costs Button (إضافة تكاليف)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showAddCostsDialog(),
                  icon: Icon(
                    Icons.receipt_long_outlined,
                    size: 18.sp,
                    color: ColorManager.primary,
                  ),
                  label: Text(
                    'إضافة تكاليف',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.primary,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ColorManager.primary),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Add Notes Button (إضافة ملاحظات)
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showAddNotesDialog(),
                  icon: Icon(
                    Icons.add_box_outlined,
                    size: 18.sp,
                    color: ColorManager.primary,
                  ),
                  label: Text(
                    'إضافة ملاحظات',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.primary,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: ColorManager.primary),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Main Action Button (إنهاء الخدمة)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isCompleted
                  ? null
                  : () => _handleCompleteService(order['id']),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isCompleted ? Colors.grey.shade300 : ColorManager.primary,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'إنهاء الخدمة',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCompleteService(String? orderId) {
    Get.dialog(
      AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text(
          'إنهاء الخدمة',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'هل أنت متأكد من إنهاء هذه الخدمة؟',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sp),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'إلغاء',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog

              // Call controller to update data state
              controller.completeOrder(orderId);

              // Show success snackbar
              Get.snackbar(
                '🎉 تم بنجاح',
                'تم إنهاء الخدمة بنجاح! شكراً لك على عملك المتميز.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
                margin: EdgeInsets.all(16.r),
                borderRadius: 12.r,
              );

              // Navigate back to dashboard and switch to My Reviews tab
              Future.delayed(const Duration(milliseconds: 500), () {
                // Go back to dashboard
                Get.until((route) => route.isFirst);
                // Change to My Reviews tab (index 2)
                controller.changeTab(2);
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'تأكيد',
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddNotesDialog() {
    final TextEditingController notesController = TextEditingController();

    Get.dialog(
      AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_add, color: ColorManager.primary, size: 24.sp),
            SizedBox(width: 8.w),
            Text(
              'إضافة ملاحظات',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: TextField(
          controller: notesController,
          maxLines: 4,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: 'اكتب ملاحظاتك هنا...',
            hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: ColorManager.primary),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'إلغاء',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'تم',
                'تم إضافة الملاحظات بنجاح',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
            ),
            child: Text(
              'حفظ',
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCostsDialog() {
    final TextEditingController costController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    Get.dialog(
      AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, color: ColorManager.primary, size: 24.sp),
            SizedBox(width: 8.w),
            Text(
              'إضافة تكاليف',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Description Field
            TextField(
              controller: descriptionController,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'وصف التكلفة (مثال: قطع غيار)',
                hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: ColorManager.primary),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            // Amount Field
            TextField(
              controller: costController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'المبلغ',
                suffixText: 'ر.ي',
                suffixStyle: TextStyle(
                  fontSize: 14.sp,
                  color: ColorManager.slateGrey,
                ),
                hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: ColorManager.primary),
                ),
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'إلغاء',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'تم',
                'تم إضافة التكلفة بنجاح',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
            ),
            child: Text(
              'إضافة',
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
