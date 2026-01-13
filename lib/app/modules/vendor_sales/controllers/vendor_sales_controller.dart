import 'package:get/get.dart';

class SaleItem {
  final String id;
  final String name;
  final String count;
  final String image;

  SaleItem(
      {required this.id,
      required this.name,
      required this.count,
      required this.image});
}

class VendorSalesController extends GetxController {
  final selectedFilter = 'أسبوعي'.obs;
  final totalSales = '1,250 د.أ'.obs;
  final growth = '10.5%'.obs;

  final topProducts = <SaleItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    topProducts.addAll([
      SaleItem(
          id: '#64748B',
          name: 'عادر مياه سير اولة',
          count: 'عدد الوحدات المباعة',
          image: 'assets/images/product1.png'),
      SaleItem(
          id: '#64748B',
          name: 'صنبور سهل الخميس',
          count: 'عدد الوحدات المباعة',
          image: 'assets/images/product2.png'),
      SaleItem(
          id: '#64748B',
          name: 'لصنت مانا اصوقين العلاقه',
          count: 'عدد الوحدات المباعة',
          image: 'assets/images/product3.png'),
      SaleItem(
          id: '#64748B',
          name: 'واهن دلال جامية',
          count: 'عدد الوحدات المباعة',
          image: 'assets/images/product4.png'),
    ]);
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    // Update chart data logic here
  }
}
