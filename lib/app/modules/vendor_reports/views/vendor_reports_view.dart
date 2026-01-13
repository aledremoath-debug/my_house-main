import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/vendor_reports_controller.dart';

class VendorReportsView extends GetView<VendorReportsController> {
  const VendorReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut shim removed in favor of Binding

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
          'التقارير',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorManager.slateGrey,
          ),
        ),
      ),
      body: GetBuilder<VendorReportsController>(
        builder: (controller) => SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              // Period Toggle
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    _buildPeriodBtn('سنوي'),
                    _buildPeriodBtn('شهري'),
                    _buildPeriodBtn('أسبوعي'),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Sales Card (Without Chart)
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            '${controller.growthPercentage.value} ↗',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                        ),
                        Text('إجمالي المبيعات',
                            style:
                                TextStyle(fontSize: 14.sp, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Text(controller.totalSales.value,
                        style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.slateGrey)),
                    SizedBox(height: 8.h),
                    Text(
                        controller.selectedPeriod.value == 'سنوي'
                            ? 'هذه السنة'
                            : controller.selectedPeriod.value == 'شهري'
                                ? 'هذا الشهر'
                                : 'آخر 7 أيام',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Best Sellers
              Align(
                alignment: Alignment.centerRight,
                child: Text('المنتجات الأكثر مبيعاً',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.slateGrey)),
              ),
              SizedBox(height: 15.h),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Builder(builder: (context) {
                  // Read the length to subscribe to list changes
                  if (controller.bestSellers.isEmpty) {
                    return const SizedBox();
                  }
                  return Column(
                    children: controller.bestSellers
                        .map((item) => Column(
                              children: [
                                ListTile(
                                  leading: Text(
                                      '#${controller.bestSellers.indexOf(item) + 1}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold)),
                                  title: Text(item.name,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp)),
                                  subtitle: Text('${item.soldCount} وحدة مباعة',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12.sp)),
                                  trailing: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.asset(item.image,
                                        width: 40.r,
                                        height: 40.r,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                if (controller.bestSellers.indexOf(item) !=
                                    controller.bestSellers.length - 1)
                                  Divider(height: 1),
                              ],
                            ))
                        .toList(),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodBtn(String title) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changePeriod(title),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: controller.selectedPeriod.value == title
                ? Colors.blue
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: controller.selectedPeriod.value == title
                  ? Colors.white
                  : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<double> data;

  ChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final spacing = width / (data.length - 1);

    path.moveTo(0, height * (1 - data[0]));

    for (int i = 0; i < data.length - 1; i++) {
      final x1 = i * spacing;
      final y1 = height * (1 - data[i]);
      final x2 = (i + 1) * spacing;
      final y2 = height * (1 - data[i + 1]);

      final controlPointX1 = x1 + (x2 - x1) / 2;
      final controlPointY1 = y1;
      final controlPointX2 = x1 + (x2 - x1) / 2;
      final controlPointY2 = y2;

      path.cubicTo(controlPointX1, controlPointY1, controlPointX2,
          controlPointY2, x2, y2);
    }

    canvas.drawPath(path, paint);

    // Fill below
    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue.withOpacity(0.3), Colors.blue.withOpacity(0.0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, width, height))
      ..style = PaintingStyle.fill;

    final fillPath = Path.from(path)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant ChartPainter oldDelegate) => true;
}
