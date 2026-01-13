import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/resources/color_manager.dart';
import '../../controllers/vendor_settings_controller.dart';

class VendorWorkingHoursView extends GetView<VendorSettingsController> {
  const VendorWorkingHoursView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'ساعات العمل',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.slateGrey,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.separated(
                    itemCount: controller.workingDays.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      final day = controller.workingDays[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          children: [
                            Text(day.dayName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: day.isOpen
                                        ? Colors.black87
                                        : Colors.grey)),
                            Spacer(),
                            Switch(
                              value: day.isOpen,
                              activeColor: ColorManager.primary,
                              onChanged: (val) =>
                                  controller.toggleDay(index, val),
                            ),
                          ],
                        ),
                        subtitle: day.isOpen
                            ? Row(
                                children: [
                                  _buildTimeChip(context, index, true,
                                      day.openTime, day.isOpen),
                                  SizedBox(width: 10.w),
                                  Text('-',
                                      style: TextStyle(color: Colors.grey)),
                                  SizedBox(width: 10.w),
                                  _buildTimeChip(context, index, false,
                                      day.closeTime, day.isOpen),
                                ],
                              )
                            : Text('مغلق',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12.sp)),
                      );
                    },
                  )),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.saveWorkingHours,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.primary,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                ),
                child: Text('حفظ التغييرات',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip(BuildContext context, int index, bool isOpenTime,
      String time, bool isDayOpen) {
    return GestureDetector(
      onTap: isDayOpen
          ? () => controller.updateTime(context, index, isOpenTime)
          : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Text(time,
                style: TextStyle(
                    fontSize: 12.sp,
                    color: isDayOpen ? Colors.black87 : Colors.grey)),
            SizedBox(width: 5.w),
            Icon(Icons.access_time, size: 14.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
