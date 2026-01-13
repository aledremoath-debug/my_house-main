import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:dotted_border/dotted_border.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
              controller.isEditing.value ? 'تعديل المنتج' : 'إضافة منتج',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorManager.slateGrey,
              ),
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Upload
              _buildImageUpload(),
              SizedBox(height: 20.h),

              // Form Fields
              _buildLabel('اسم المنتج'),
              _buildTextField(
                  hint: 'مثال: فلتر مياه 5 مراحل',
                  controller: controller.nameController),

              SizedBox(height: 15.h),

              SizedBox(height: 15.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('الكمية'),
                        _buildNumberField(
                            hint: '0',
                            controller: controller.quantityController),
                      ],
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('السعر'),
                        _buildNumberField(
                            hint: '0.00 ر.ي',
                            controller: controller.priceController),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15.h),
              _buildLabel('وصف المنتج'),
              _buildTextField(
                  hint: 'اكتب وصفاً تفصيلياً للمنتج هنا...',
                  maxLines: 4,
                  controller: controller.descriptionController),

              SizedBox(height: 15.h),
              _buildLabel('مواصفات المنتج '),
              _buildTextField(
                  hint:
                      'اكتب كل مواصفة في سطر جديد.\nمثال:\nاللون: أحمر\nالضمان: سنة',
                  maxLines: 4,
                  controller: controller.additionalSpecsController),

              SizedBox(height: 30.h),
              _buildPublishButton(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageUpload() {
    return Obx(() {
      if (controller.imagePaths.isEmpty) {
        return GestureDetector(
          onTap: controller.pickImage,
          child: Container(
            width: double.infinity,
            height: 150.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: Colors.grey.shade400, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.image, color: Colors.orange, size: 30.sp),
                ),
                SizedBox(height: 10.h),
                Text(
                  'إضافة صور المنتج',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.slateGrey,
                  ),
                ),
                Text(
                  'اضغط هنا لرفع صور متعددة',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return SizedBox(
          height: 150.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.imagePaths.length + 1,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              if (index == controller.imagePaths.length) {
                // Add more button at the end
                return GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: Colors.grey.shade400, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate,
                            color: Colors.grey, size: 30.sp),
                        SizedBox(height: 5.h),
                        Text('إضافة',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.grey)),
                      ],
                    ),
                  ),
                );
              }
              final path = controller.imagePaths[index];
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: path.startsWith('assets')
                        ? Image.asset(
                            path,
                            fit: BoxFit.cover,
                            width: 120.w,
                            height: 150.h,
                          )
                        : Image.file(
                            File(path),
                            fit: BoxFit.cover,
                            width: 120.w,
                            height: 150.h,
                          ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () => controller.removeImage(index),
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child:
                            Icon(Icons.close, color: Colors.white, size: 16.sp),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }
    });
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: ColorManager.slateGrey,
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String hint,
      int maxLines = 1,
      required TextEditingController controller}) {
    return TextField(
      maxLines: maxLines,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13.sp),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
      ),
    );
  }

  Widget _buildNumberField(
      {required String hint, required TextEditingController controller}) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13.sp),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: ColorManager.primary),
        ),
      ),
    );
  }

  Widget _buildPublishButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.publishProduct,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.blue,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: Obx(() => Text(
              controller.isEditing.value ? 'تحديث المنتج' : 'نشر المنتج',
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
