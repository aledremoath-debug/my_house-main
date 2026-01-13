import 'package:get/get.dart';

class BestSeller {
  final String name;
  final int soldCount;
  final String image;

  BestSeller(
      {required this.name, required this.soldCount, required this.image});
}

class VendorReportsController extends GetxController {
  final selectedPeriod = 'أسبوعي'.obs;
  final totalSales = '1,250 ر.ي'.obs;
  final growthPercentage = '+10.5%'.obs;
  final bestSellers = <BestSeller>[].obs;
  final chartData = <double>[].obs;

  @override
  void onInit() {
    super.onInit();
    changePeriod('أسبوعي'); // Initialize with weekly data
  }

  void changePeriod(String period) {
    selectedPeriod.value = period;

    if (period == 'أسبوعي') {
      totalSales.value = '1,250 ر.ي';
      growthPercentage.value = '+10.5%';
      chartData.assignAll([0.2, 0.4, 0.3, 0.6, 0.5, 0.8, 0.7]);
      bestSellers.assignAll([
        BestSeller(
            name: 'فلتر مياه - مرحلة أولى',
            soldCount: 45,
            image: 'assets/images/product1.png'),
        BestSeller(
            name: 'حساس موقد غاز',
            soldCount: 32,
            image: 'assets/images/product1.png'),
        BestSeller(
            name: 'أنبوب مياه مرن',
            soldCount: 28,
            image: 'assets/images/product1.png'),
      ]);
    } else if (period == 'شهري') {
      totalSales.value = '15,400 ر.ي';
      growthPercentage.value = '+22.1%';
      chartData.assignAll([0.5, 0.6, 0.8, 0.4, 0.7, 0.9, 0.6]);
      bestSellers.assignAll([
        BestSeller(
            name: 'لمبة LED موفرة للطاقة',
            soldCount: 150,
            image: 'assets/images/product1.png'),
        BestSeller(
            name: 'منظم حرارة ذكي',
            soldCount: 120,
            image: 'assets/images/product1.png'),
        BestSeller(
            name: 'فلتر مياه - مرحلة أولى',
            soldCount: 95,
            image: 'assets/images/product1.png'),
      ]);
    } else if (period == 'سنوي') {
      totalSales.value = '180,000 ر.ي';
      growthPercentage.value = '+35.0%';
      chartData.assignAll([0.3, 0.5, 0.4, 0.7, 0.6, 0.8, 0.9]);
      bestSellers.assignAll([
        BestSeller(
            name: 'نظام أمان منزلي',
            soldCount: 500,
            image: 'assets/images/product1.png'),
        BestSeller(
            name: 'مكيف هواء سبليت',
            soldCount: 350,
            image: 'assets/images/product1.png'),
        BestSeller(
            name: 'سخان مياه فوري',
            soldCount: 300,
            image: 'assets/images/product1.png'),
      ]);
    }
    update();
  }
}
