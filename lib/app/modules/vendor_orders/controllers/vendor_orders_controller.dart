import 'package:get/get.dart';

class Order {
  final String id;
  final String date;
  final String customerName;
  final String itemCount;
  final String price;
  final String status; // 'جديد', 'قيد التجهيز', 'مكتمل', 'ملغي', 'جاهز للشحن'

  Order({
    required this.id,
    required this.date,
    required this.customerName,
    required this.itemCount,
    required this.price,
    required this.status,
  });
}

class VendorOrdersController extends GetxController {
  final orders = <Order>[].obs;
  final filteredOrders = <Order>[].obs;
  final selectedFilter = 'الكل'.obs;

  @override
  void onInit() {
    super.onInit();
    // Dummy Data
    orders.addAll([
      Order(
        id: '10234',
        date: '15 يوليو, 2023 - 10:30 ص',
        customerName: 'اسم العميل',
        itemCount: '3 منتجات',
        price: '250.00 ر.ي',
        status: 'جديد',
      ),
      Order(
        id: '10233',
        date: '14 يوليو, 2023 - 08:15 م',
        customerName: 'اسم عميل آخر',
        itemCount: '1 منتج',
        price: '99.50 ر.ي',
        status: 'قيد التجهيز',
      ),
      Order(
        id: '10232',
        date: '14 يوليو, 2023 - 05:00 م',
        customerName: 'عبدالله محمد',
        itemCount: '5 منتجات',
        price: '480.00 ر.ي',
        status: 'مكتمل',
      ),
      Order(
        id: '10231',
        date: '13 يوليو, 2023 - 11:45 ص',
        customerName: 'سارة علي',
        itemCount: '2 منتج',
        price: '150.00 ر.ي',
        status: 'ملغي',
      ),
    ]);
    filterOrders('الكل');
  }

  final isSearching = false.obs;
  final searchQuery = ''.obs;

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchQuery.value = '';
      _applyFilters();
    }
  }

  void updateSearch(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  void filterOrders(String filter) {
    selectedFilter.value = filter;
    _applyFilters();
  }

  void _applyFilters() {
    List<Order> tempOrders = orders;

    // Apply Status Filter
    if (selectedFilter.value != 'الكل') {
      tempOrders =
          tempOrders.where((o) => o.status == selectedFilter.value).toList();
    }

    // Apply Search Filter
    if (searchQuery.value.isNotEmpty) {
      tempOrders = tempOrders
          .where((o) =>
              o.id.contains(searchQuery.value) ||
              o.customerName.contains(searchQuery.value))
          .toList();
    }

    filteredOrders.value = tempOrders;
  }

  void rejectOrder(String orderId, String reason) {
    final index = orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      final order = orders[index];
      orders[index] = Order(
        id: order.id,
        date: order.date,
        customerName: order.customerName,
        itemCount: order.itemCount,
        price: order.price,
        status: 'ملغي',
      );
      _applyFilters();
      // In a real app, you would also save the reason to the backend
      print('Order $orderId rejected. Reason: $reason');
    }
  }
}
