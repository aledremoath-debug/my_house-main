import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/vendor_order_details_controller.dart';

class VendorOrderDetailsView extends GetView<VendorOrderDetailsController> {
  const VendorOrderDetailsView({super.key});

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
        title: Text(
          'تفاصيل الطلب',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.slateGrey,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderInfoCard(),
              SizedBox(height: 20.h),
              Text(
                'المنتجات المطلوبة',
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.slateGrey),
              ),
              SizedBox(height: 10.h),
              _buildProductsList(),
              SizedBox(height: 20.h),
              _buildSummaryCard(),
              SizedBox(height: 30.h),
              _buildActionButtons(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderInfoCard() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          _buildInfoRow('طلب رقم', controller.orderId.value),
          Divider(),
          _buildInfoRow('تاريخ الطلب', controller.orderDate.value),
          Divider(),
          _buildInfoRow('حالة الطلب', controller.orderStatus.value,
              isStatus: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
          Text(value,
              style: TextStyle(
                  color: isStatus
                      ? ColorManager.secondary
                      : ColorManager.slateGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp))
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            final item = controller.items[index];
            return Container(
              margin: EdgeInsets.only(bottom: 15.h),
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.slateGrey),
                        ),
                        Text(
                          item.price,
                          style: TextStyle(
                              fontSize: 14.sp, color: ColorManager.slateGrey),
                        ),
                        Text(
                          item.quantity,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey.shade100),
                    child: ClipRRect(
                      // Clip image to border radius
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(item.image, fit: BoxFit.cover),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('المجموع الفرعي',
                  style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
              Obx(() => Text(controller.subTotal.value,
                  style: TextStyle(
                      color: ColorManager.slateGrey, fontSize: 14.sp))),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الإجمالى',
                  style: TextStyle(
                      color: ColorManager.slateGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp)),
              Obx(() => Text(controller.total.value,
                  style: TextStyle(
                      color: ColorManager.slateGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.acceptOrder,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.secondary,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: Text(
          'قبول وتجهيز الطلب',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
