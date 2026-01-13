import 'package:figma_squircle/figma_squircle.dart';
import 'package:my_house/app/core/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FailedMessage extends StatelessWidget {
  final String message;
  const FailedMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: ShapeDecoration(
        color: const Color(0xFFFFEBEE), // Light Red
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 16,
            cornerSmoothing: 1,
          ),
        ),
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Status Icon
          Container(
            width: 48.w,
            height: 48.w,
            decoration: const BoxDecoration(
              color: Color(0xFFC62828), // Red
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.close, color: Colors.white, size: 28.sp),
          ),
          SizedBox(width: 12.w),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'فشل الإرسال',
                  style: FontManager.h2_16_400(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  message,
                  style: FontManager.h3_12_400(color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          // Close Icon
          Icon(Icons.close, color: Colors.grey.shade400, size: 24.sp),
        ],
      ),
    );
  }
}
