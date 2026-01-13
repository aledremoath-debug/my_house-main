import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../../../routes/app_pages.dart';
import '../controllers/vendor_orders_controller.dart';

class VendorOrdersView extends GetView<VendorOrdersController> {
  const VendorOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false, // Removed back button
          title: Obx(() => controller.isSearching.value
              ? TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: 'بحث برقم الطلب أو اسم العميل...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey)),
                  style: TextStyle(color: ColorManager.slateGrey),
                  onChanged: controller.updateSearch,
                )
              : Text(
                  'طلبات المتجر',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.slateGrey,
                  ),
                )),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: IconButton(
                  onPressed: controller.toggleSearch,
                  icon: Obx(() => Icon(
                      controller.isSearching.value ? Icons.close : Icons.search,
                      color: ColorManager.slateGrey,
                      size: 28.sp))),
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              _buildTabs(),
              Expanded(
                child: Obx(() => ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      itemCount: controller.filteredOrders.length,
                      itemBuilder: (context, index) {
                        return _buildOrderCard(
                            controller.filteredOrders[index]);
                      },
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    final filters = [
      'الكل',
      'جديد',
      'قيد التجهيز',
      'جاهز للشحن',
      'مكتمل',
      'ملغي'
    ];
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          return Obx(() {
            final isSelected = controller.selectedFilter.value == filter;
            return GestureDetector(
              onTap: () => controller.filterOrders(filter),
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: isSelected
                      ? Border(
                          bottom: BorderSide(
                              color: ColorManager.secondary, width: 2))
                      : null,
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? ColorManager.secondary : Colors.grey,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'طلب #${order.id}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.slateGrey,
                ),
              ),
              _buildStatusChip(order.status),
            ],
          ),
          Text(
            order.date,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
          Divider(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.person_outline,
                      size: 20.sp, color: ColorManager.slateGrey),
                  SizedBox(width: 5.w),
                  Text(
                    order.customerName,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: ColorManager.slateGrey,
                    ),
                  ),
                ],
              ),
              Text(
                order.itemCount,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.price,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.slateGrey,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              // View Details Button
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.toNamed(Routes.VENDOR_ORDER_DETAILS);
                  },
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: ColorManager.secondary),
                      backgroundColor: ColorManager.secondary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                      padding: EdgeInsets.symmetric(vertical: 12.h)),
                  child: Text('عرض التفاصيل',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(width: 10.w),
              // Reject Order Button
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showRejectDialog(order),
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                      backgroundColor: Colors.red.shade50,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r)),
                      padding: EdgeInsets.symmetric(vertical: 12.h)),
                  child: Text('رفض الطلب',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    Color bgColor;

    switch (status) {
      case 'جديد':
        color = ColorManager.secondary;
        bgColor = ColorManager.secondary.withOpacity(0.1);
        break;
      case 'قيد التجهيز':
        color = Colors.orange;
        bgColor = Colors.orange.withOpacity(0.1);
        break;
      case 'مكتمل':
        color = Colors.green;
        bgColor = Colors.green.withOpacity(0.1);
        break;
      case 'ملغي':
        color = Colors.red;
        bgColor = Colors.red.withOpacity(0.1);
        break;
      default:
        color = Colors.blue;
        bgColor = Colors.blue.withOpacity(0.1);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12.sp,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showRejectDialog(Order order) {
    final TextEditingController reasonController = TextEditingController();
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          'رفض الطلب',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.slateGrey,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'هل أنت متأكد من رفض الطلب رقم #${order.id}؟',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(height: 15.h),
            TextField(
              controller: reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'أدخل سبب الرفض...',
                hintStyle:
                    TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.red),
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
              if (reasonController.text.isEmpty) {
                Get.snackbar(
                  'تنبيه',
                  'يرجى إدخال سبب الرفض',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                );
                return;
              }
              Get.back();
              controller.rejectOrder(order.id, reasonController.text);
              Get.snackbar(
                'تم الرفض',
                'تم رفض الطلب #${order.id} بنجاح',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'تأكيد الرفض',
              style: TextStyle(fontSize: 14.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
