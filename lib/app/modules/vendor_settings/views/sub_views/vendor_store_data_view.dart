import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/resources/color_manager.dart';
import '../../controllers/vendor_settings_controller.dart';
import 'vendor_working_hours_view.dart';

class VendorStoreDataView extends GetView<VendorSettingsController> {
  const VendorStoreDataView({super.key});

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
          'بيانات المتجر',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.slateGrey,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImagesSection(),
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  _buildTextField(
                      label: 'اسم المتجر',
                      hint: 'أدخل اسم المتجر',
                      controller: controller.storeNameController),
                  SizedBox(height: 20.h),
                  _buildTextField(
                      label: 'وصف المتجر',
                      hint: 'أدخل وصف مختصر للمتجر',
                      maxLines: 3,
                      controller: controller.storeDescController),
                  SizedBox(height: 20.h),
                  _buildWorkingHoursSummary(),
                  SizedBox(height: 40.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.saveStoreData,
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
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagesSection() {
    return SizedBox(
      height: 220.h,
      child: Stack(
        children: [
          // Profile Image (Logo)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                children: [
                  Obx(() {
                    final logoPath = controller.storeLogo.value;
                    return CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 47.r,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: logoPath.isNotEmpty
                            ? FileImage(File(logoPath))
                            : const AssetImage('assets/images/product1.png')
                                as ImageProvider,
                      ),
                    );
                  }),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => controller.pickStoreImage(true),
                      child: CircleAvatar(
                        radius: 16.r,
                        backgroundColor: ColorManager.primary,
                        child: Icon(Icons.camera_alt,
                            color: Colors.white, size: 16.sp),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required String hint,
      int maxLines = 1,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.slateGrey)),
        SizedBox(height: 10.h),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingHoursSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ساعات العمل',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.slateGrey)),
            TextButton(
              onPressed: () => Get.to(() => const VendorWorkingHoursView()),
              child: Text('تعديل',
                  style:
                      TextStyle(fontSize: 12.sp, color: ColorManager.primary)),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Obx(() {
            final openDays =
                controller.workingDays.where((d) => d.isOpen).toList();
            if (openDays.isEmpty) {
              return Text('المتجر مغلق دائماً',
                  style: TextStyle(color: Colors.grey));
            }
            return Column(
              children: openDays.map((day) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Row(
                    children: [
                      Text(day.dayName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.sp)),
                      Spacer(),
                      Text('${day.openTime} - ${day.closeTime}',
                          style: TextStyle(
                              color: ColorManager.slateGrey, fontSize: 12.sp)),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ],
    );
  }
}
