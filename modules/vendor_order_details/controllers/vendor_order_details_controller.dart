import 'package:get/get.dart';

class OrderItem {
  final String name;
  final String quantity;
  final String price;
  final String image;

  OrderItem(
      {required this.name,
      required this.quantity,
      required this.price,
      required this.image});
}

class VendorOrderDetailsController extends GetxController {
  // Observables for order details
  final orderId = '#12345'.obs;
  final orderDate = '21 أكتوبر, 2023 , 09:30 ص'.obs;
  final orderStatus = 'جديد'.obs;

  final items = <OrderItem>[].obs;
  final subTotal = '300 ريال'.obs;
  final total = '300 ريال'.obs;

  @override
  void onInit() {
    super.onInit();
    // Load dummy data
    items.addAll([
      OrderItem(
          name: 'فلتر مياه سيراميك',
          quantity: 'الكمية: 1',
          price: '150 ريال',
          image: 'assets/images/product2.png'),
      OrderItem(
          name: 'قطعة غيار خلاط',
          quantity: 'الكمية: 2',
          price: '150 ريال',
          image: 'assets/images/product3.png'),
    ]);
  }

  void acceptOrder() {
    Get.snackbar('تم', 'تم قبول الطلب وجاري التجهيز');
    // Update status logic
  }

  void rejectOrder() {
    Get.snackbar('تم', 'تم رفض الطلب');
    // Update status logic
  }
}
