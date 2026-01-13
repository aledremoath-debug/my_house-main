import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/services/vendor_service.dart';
import '../controllers/my_products_controller.dart';

class ProductDetailsView extends GetView<MyProductsController> {
  final Product product;
  final TextEditingController quantityEditController;

  ProductDetailsView({Key? key, required this.product})
      : quantityEditController =
            TextEditingController(text: product.quantity ?? '0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'تفاصيل المنتج',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        // Find the reactive product from the controller's list
        final reactiveProduct = controller.products.firstWhere(
          (p) => p.id == product.id,
          orElse: () => product,
        );

        return SingleChildScrollView(
          child: Column(
            children: [
              // Product Image Header
              Container(
                height: 350.h, // Slightly taller for better view
                width: double.infinity,
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // Image Slider
                    PageView.builder(
                      itemCount: reactiveProduct.images.length,
                      onPageChanged: (index) {
                        controller.currentImageIndex.value = index;
                      },
                      itemBuilder: (context, index) {
                        final imagePath = reactiveProduct.images[index];
                        return Container(
                          width: double.infinity,
                          child: imagePath.startsWith('assets')
                              ? Image.asset(
                                  imagePath,
                                  fit: BoxFit.contain,
                                )
                              : Image.file(
                                  File(imagePath),
                                  fit: BoxFit.cover,
                                ),
                        );
                      },
                    ),

                    // Pagination Dots
                    if (reactiveProduct.images.length > 1)
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                reactiveProduct.images.length,
                                (index) => _buildDot(index ==
                                    controller.currentImageIndex.value),
                              ),
                            )),
                      )
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Product Info Card
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reactiveProduct.name,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      reactiveProduct.price,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2563EB)),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      reactiveProduct.description ?? 'لا يوجد وصف للمنتج',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Stock Card
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المخزون المتوفر',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.inventory_2_outlined,
                              color: Color(0xFF2563EB)),
                          SizedBox(width: 10.w),
                          Text('الكمية الحالية',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87)),
                          const Spacer(),
                          Text('${reactiveProduct.quantity ?? 0} قطعة',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text('تحديث الكمية',
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Container(
                          width: 80.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDBEAFE),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: TextButton(
                            onPressed: () {
                              controller.updateProductQuantity(
                                  reactiveProduct, quantityEditController.text);
                            },
                            child: Text('تحديث',
                                style: TextStyle(
                                    color: Color(0xFF2563EB),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(10.r),
                              color: Colors.white,
                            ),
                            child: TextField(
                              controller: quantityEditController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // Specifications Card
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المواصفات',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    if (reactiveProduct.additionalSpecs != null &&
                        reactiveProduct.additionalSpecs!.isNotEmpty)
                      ...reactiveProduct.additionalSpecs!
                          .split('\n')
                          .map((spec) {
                        if (spec.contains(':')) {
                          final parts = spec.split(':');
                          if (parts.length >= 2) {
                            return _buildSpecRow(parts[0].trim(),
                                parts.sublist(1).join(':').trim());
                          }
                        }
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            spec,
                            style: TextStyle(
                                fontSize: 13.sp, color: Colors.grey[800]),
                          ),
                        );
                      }).toList()
                    else
                      Text(
                        'لا توجد مواصفات إضافية',
                        style:
                            TextStyle(fontSize: 13.sp, color: Colors.grey[500]),
                      ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () {
                  Get.back(); // Close details
                  controller.onEditProduct(product);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  elevation: 0,
                ),
                child: Text('تعديل المنتج',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  controller.deleteProduct(product, onSuccess: () {
                    Get.back(); // Close the details view
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFEF2F2),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  elevation: 0,
                ),
                child: Text('حذف المنتج',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEF4444))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: child,
    );
  }

  Widget _buildDot(bool active) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      width: 7.w,
      height: 7.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB),
      ),
    );
  }
}
