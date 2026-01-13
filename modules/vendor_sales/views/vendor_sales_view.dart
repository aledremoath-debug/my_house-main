import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/resources/color_manager.dart';
import '../controllers/vendor_sales_controller.dart';

class VendorSalesView extends GetView<VendorSalesController> {
  const VendorSalesView({super.key});

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
          'تقرير المبيعات',
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
              // Filters
              _buildFilters(),
              SizedBox(height: 20.h),

              // Chart Card
              _buildChartCard(),
              SizedBox(height: 30.h),

              // Top Products
              Text(
                'المنتجات الأكثر مبيعاً',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.slateGrey,
                ),
              ),
              SizedBox(height: 15.h),
              _buildTopProductsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    final filters = ['أسبوعي', 'شهري', 'سنوي'];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: filters
            .map((f) => Expanded(child: Obx(() {
                  final isSelected = controller.selectedFilter.value == f;
                  return GestureDetector(
                    onTap: () => controller.setFilter(f),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                })))
            .toList(),
      ),
    );
  }

  Widget _buildChartCard() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'إجمالي المبيعات',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
          Row(
            children: [
              /* Obx(() => Text(
                              controller.totalSales.value,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: ColorManager.slateGrey),
                          )),*/
              Obx(() => Text(
                    controller.totalSales.value,
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.slateGrey),
                  )),
            ],
          ),
          Row(
            children: [
              Text(
                'آخر 7 أيام ',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
              Obx(() => Text(
                    controller.growth.value,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  )),
              Icon(Icons.arrow_upward, color: Colors.green, size: 12.sp)
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 150.h,
            child: LineChart(LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const titles = [
                              'السبت',
                              'الجمعة',
                              'الخميس',
                              'الأربعاء',
                              'الثلاثاء',
                              'الاثنين',
                              'الأحد'
                            ];
                            if (value.toInt() >= 0 &&
                                value.toInt() < titles.length) {
                              return Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: Text(titles[value.toInt()],
                                    style: TextStyle(
                                        fontSize: 10.sp, color: Colors.grey)),
                              );
                            }
                            return const SizedBox();
                          })),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 3),
                      FlSpot(1, 1.5),
                      FlSpot(2, 4),
                      FlSpot(3, 2.5),
                      FlSpot(4, 3.5),
                      FlSpot(5, 4.5),
                      FlSpot(6, 2),
                    ],
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.blue.withOpacity(0.1),
                    ),
                  ),
                ])),
          ),
        ],
      ),
    );
  }

  Widget _buildTopProductsList() {
    return Obx(() => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.topProducts.length,
          separatorBuilder: (c, i) => Divider(height: 1),
          itemBuilder: (context, index) {
            final product = controller.topProducts[index];
            return Container(
              padding: EdgeInsets.all(15.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                children: [
                  Text(
                    product.id,
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.sp),
                        ),
                        Text(
                          product.count,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                            image: AssetImage(product.image),
                            fit: BoxFit.cover)),
                    // child: Image.asset(product.image, fit: BoxFit.cover),
                  )
                ],
              ),
            );
          },
        ));
  }
}
