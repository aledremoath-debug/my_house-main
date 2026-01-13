import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/provider_dashboard_controller.dart';

class ProviderAddServiceView extends GetView<ProviderDashboardController> {
  const ProviderAddServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            SizedBox(height: 24.h),

            // Service Details Card
            _buildServiceDetailsCard(),
            SizedBox(height: 20.h),

            // Service Images Card
            _buildServiceImagesCard(),
            SizedBox(height: 28.h),

            // Publish Button
            _buildPublishButton(),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Button
        Container(
          decoration: BoxDecoration(
            color: ColorManager.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              // Reset Logic extracted for cleaner code
              controller.isEditing.value = false;
              controller.editingServiceId.value = ''; // Reset ID
              controller.serviceNameController.clear();
              controller.serviceDescriptionController.clear();
              controller.servicePriceController.clear();
              controller.selectedImages.clear();
              // Go back to My Services tab (index 3) is more logical than Home (0)
              controller.changeTab(3);
            },
            icon: Icon(
              Icons
                  .arrow_forward, // Arrow points left in RTL but we use arrow_forward as base
              size: 20.sp,
              color: ColorManager.primary,
            ),
          ),
        ),

        // Title
        Obx(() => Text(
              controller.isEditing.value ? 'تعديل الخدمة' : 'إضافة خدمة جديدة',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.slateGrey,
              ),
            )),

        // Spacer
        SizedBox(width: 48.w),
      ],
    );
  }

  Widget _buildServiceDetailsCard() {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Section Title
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'تفاصيل الخدمة',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.slateGrey,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.description_outlined,
                  color: ColorManager.primary, size: 22.sp),
            ],
          ),
          SizedBox(height: 24.h),

          // Service Name Field
          _buildLabeledField(
            label: 'اسم الخدمة',
            child: TextField(
              controller: controller.serviceNameController,
              textAlign: TextAlign.right,
              decoration:
                  _buildInputDecoration(hint: 'مثال: تنظيف مكيفات سبليت'),
            ),
          ),
          SizedBox(height: 18.h),

          // Service Description Field
          _buildLabeledField(
            label: 'وصف الخدمة',
            child: TextField(
              controller: controller.serviceDescriptionController,
              maxLines: 4,
              textAlign: TextAlign.right,
              decoration: _buildInputDecoration(
                  hint: 'اكتب وصفاً مفصلاً للخدمة التي تقدمها...'),
            ),
          ),
          SizedBox(height: 18.h),

          // Region and Price Row
          Row(
            children: [
              // Region Dropdown
              Expanded(
                child: _buildLabeledField(
                  label: 'منطقة التغطية',
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: Obx(() {
                      const regions = ['صنعاء', 'الحديدة', 'إب', 'عدن', 'تعز'];
                      return DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value:
                              regions.contains(controller.selectedRegion.value)
                                  ? controller.selectedRegion.value
                                  : null,
                          hint: Text('اختر المنطقة',
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey)),
                          icon: Icon(Icons.keyboard_arrow_down,
                              color: ColorManager.primary),
                          items: regions
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        e,
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value != null)
                              controller.selectedRegion.value = value;
                          },
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(width: 16.w),

              // Price Field
              Expanded(
                child: _buildLabeledField(
                  label: 'السعر تقديراً',
                  child: TextField(
                    controller: controller.servicePriceController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.right,
                    decoration: _buildInputDecoration(
                      hint: '0.00',
                      suffix: Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Text('ريال',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 13.sp)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration(
      {required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade400),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.grey.shade100),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.grey.shade100),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorManager.primary, width: 1.5),
      ),
    );
  }

  Widget _buildLabeledField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: ColorManager.slateGrey,
          ),
        ),
        SizedBox(height: 10.h),
        child,
      ],
    );
  }

  Widget _buildServiceImagesCard() {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Title
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'صور الخدمة',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.slateGrey,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.camera_alt_outlined,
                  color: ColorManager.primary, size: 22.sp),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'أضف صوراً توضح الخدمة التي تقدمها',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 24.h),

          // Images Grid
          Obx(() => Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                alignment: WrapAlignment.end,
                children: [
                  // Selected Images
                  ...controller.selectedImages.map((imagePath) => Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.file(
                              File(imagePath),
                              width: 90.w,
                              height: 90.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: -6.h,
                            left: -6.w,
                            child: GestureDetector(
                              onTap: () =>
                                  controller.selectedImages.remove(imagePath),
                              child: Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.close,
                                    size: 14.sp, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )),

                  // Add Image Button (Only show if less than 5 images)
                  if (controller.selectedImages.length < 5)
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          controller.selectedImages.add(image.path);
                        }
                      },
                      child: Container(
                        width: 90.w,
                        height: 90.h,
                        decoration: BoxDecoration(
                          color: ColorManager.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: ColorManager.primary.withOpacity(0.2),
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo,
                                color: ColorManager.primary, size: 28.sp),
                            SizedBox(height: 4.h),
                            Text(
                              'إضافة',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: ColorManager.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildPublishButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        gradient: LinearGradient(
          colors: [
            ColorManager.primary,
            ColorManager.primary.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: controller.addService,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
        ),
        child: Obx(() => Text(
              controller.isEditing.value ? 'تحديث الخدمة' : 'حفظ ونشر الخدمة',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
