import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../routes/app_pages.dart';
import '../views/provider_add_service_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderDashboardController extends GetxController {
  // Tab Navigation for BottomNavBar
  final tabIndex = 0.obs;

  // Availability Status
  final isAvailable = true.obs;

  // Add Service Form Fields
  final serviceNameController = TextEditingController();
  final serviceDescriptionController = TextEditingController();
  final servicePriceController = TextEditingController();
  final selectedRegion = 'صنعاء'.obs;
  final selectedImages = <String>[].obs;
  final isEditing = false.obs;
  final editingServiceId = ''.obs;

  // Stats
  final totalEarnings = 4500.obs;
  final completedOrders = 32.obs;
  final averageRating = 4.8.obs;
  final totalReviews = 150.obs;

  // Provider Info
  final providerName = 'عبدالله الأحمدي'.obs;
  final providerTitle = 'فني تكييف'.obs;
  final providerLocation = 'صنعاء، عدن'.obs;

  // Dummy Data for Orders List (Status: New, In Progress, Completed, Rejected)
  final newOrders = <Map<String, dynamic>>[].obs;
  final inProgressOrders = <Map<String, dynamic>>[].obs;
  final completedOrdersList = <Map<String, dynamic>>[].obs;
  final rejectedOrders = <Map<String, dynamic>>[].obs;

  // Latest Orders for Dashboard
  final latestOrdersOverview = <Map<String, dynamic>>[].obs;

  // My Services List
  final myServices = <Map<String, dynamic>>[].obs;

  // My Reviews List
  final myReviews = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    // Dashboard Latest Orders
    latestOrdersOverview.value = [
      {
        'id': '101',
        'title': 'تنظيف مكيفات سبليت',
        'image': 'assets/images/product1.png',
        'location': 'حي الياسمين',
        'time': 'قبل 30 دقيقة',
        'status': 'بانتظار الموافقة',
        'clientName': 'محمد العمري',
        'phone': '967777123456',
        'date': 'الثلاثاء، 25 أكتوبر، 2023',
      },
      {
        'id': '102',
        'title': 'تركيب إنارة حديثة',
        'image': 'assets/images/product2.png',
        'location': 'حي النرجس',
        'time': 'قبل 45 دقيقة',
        'status': 'بانتظار الموافقة',
        'clientName': 'أحمد السعيد',
        'phone': '967777654321',
        'date': 'الأربعاء، 26 أكتوبر، 2023',
      },
    ];

    // Orders Page - New Orders
    newOrders.value = [
      {
        'id': '201',
        'category': 'سباكة',
        'title': 'إصلاح تسريب صنبور المطبخ',
        'clientName': 'خالد الأحمدي',
        'phone': '967771234567',
        'date': '25 أكتوبر',
        'time': '10:30 صباحاً',
        'location': 'حي حدة، صنعاء',
        'icon': Icons.plumbing,
        'color': const Color(0xFFE0F7FA), // Light Cyan
        'iconColor': const Color(0xFF00BCD4), // Cyan
      },
      {
        'id': '202',
        'category': 'كهرباء',
        'title': 'تركيب إضاءة سقف جديدة',
        'clientName': 'فاطمة عبدالله',
        'phone': '967779876543',
        'date': '25 أكتوبر',
        'time': '02:00 مساءً',
        'location': 'حي المنصورة، عدن',
        'icon': Icons.electrical_services,
        'color': const Color(0xFFE1F5FE), // Light Blue
        'iconColor': const Color(0xFF03A9F4), // Light Blue
      },
    ];

    // My Services List
    myServices.value = [
      {
        'id': '1',
        'title': 'تصليح مكيفات سبليت',
        'description': 'فحص وصيانة شاملة لوحدات التكييف',
        'price': 150,
        'image': 'assets/images/product1.png',
        'icon': Icons.ac_unit,
        'region': 'صنعاء',
      },
      {
        'id': '2',
        'title': 'تنظيف خزانات المياه',
        'description': 'تنظيف وتعقيم كامل لخزانات المياه العلوية',
        'price': 250,
        'image': 'assets/images/product2.png',
        'icon': Icons.water_drop,
        'region': 'صنعاء',
      },
      {
        'id': '3',
        'title': 'تركيب إضاءة LED',
        'description': 'تركيب وتوزيع الإضاءة المخفية والسبوت لايت',
        'price': 0,
        'priceNote': 'حسب عدد النقاط',
        'image': 'assets/images/product3.png',
        'icon': Icons.lightbulb,
        'region': 'صنعاء',
      },
    ];

    // My Reviews / Completed Jobs with Ratings
    myReviews.value = [
      {
        'id': '1',
        'jobTitle': 'تصليح مكيفات سبليت',
        'clientName': 'عبدالله الراجحي',
        'location': 'حي حدة، صنعاء',
        'completedDate': '20 أكتوبر 2023',
        'rating': 5,
        'comment':
            'عمل ممتاز جداً! الفني محترف وملتزم بالوقت. أنصح بالتعامل معه.',
        'price': 350,
        'icon': Icons.ac_unit,
        'iconColor': const Color(0xFF03A9F4),
      },
      {
        'id': '2',
        'jobTitle': 'تركيب إضاءة سقف',
        'clientName': 'فاطمة أحمد',
        'location': 'حي المنصورة، عدن',
        'completedDate': '18 أكتوبر 2023',
        'rating': 4,
        'comment': 'خدمة جيدة، الفني متعاون ومحترف. شكراً لكم.',
        'price': 200,
        'icon': Icons.lightbulb,
        'iconColor': const Color(0xFFFFC107),
      },
      {
        'id': '3',
        'jobTitle': 'إصلاح تسريب مياه',
        'clientName': 'محمد العمري',
        'location': 'حي الياسمين، صنعاء',
        'completedDate': '15 أكتوبر 2023',
        'rating': 5,
        'comment': 'سرعة في الاستجابة وجودة عالية في العمل. ممتاز!',
        'price': 150,
        'icon': Icons.plumbing,
        'iconColor': const Color(0xFF00BCD4),
      },
      {
        'id': '4',
        'jobTitle': 'صيانة كهربائية شاملة',
        'clientName': 'خالد السعيد',
        'location': 'حي النهضة، تعز',
        'completedDate': '12 أكتوبر 2023',
        'rating': 5,
        'comment': 'أفضل فني تعاملت معه. عمل احترافي ونظيف جداً.',
        'price': 500,
        'icon': Icons.electrical_services,
        'iconColor': const Color(0xFFFF9800),
      },
      {
        'id': '5',
        'jobTitle': 'تنظيف خزانات مياه',
        'clientName': 'سارة الحسن',
        'location': 'حي الروضة، صنعاء',
        'completedDate': '10 أكتوبر 2023',
        'rating': 4,
        'comment': 'خدمة ممتازة والسعر مناسب. شكراً.',
        'price': 250,
        'icon': Icons.water_drop,
        'iconColor': const Color(0xFF2196F3),
      },
    ];
  }

  void changeTab(int index) {
    tabIndex.value = index;
  }

  void toggleAvailability() {
    isAvailable.value = !isAvailable.value;
    Get.snackbar(
      isAvailable.value ? 'متاح الآن' : 'غير متاح',
      isAvailable.value
          ? 'يمكنك الآن استقبال طلبات جديدة'
          : 'لن تستقبل طلبات جديدة',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isAvailable.value ? Colors.green : Colors.orange,
      colorText: Colors.white,
    );
  }

  void acceptOrder(String? orderId) {
    // Find the order details in latestOrdersOverview or newOrders
    var order = latestOrdersOverview.firstWhere(
      (o) => o['id'] == orderId,
      orElse: () => <String, dynamic>{},
    );

    if (order.isEmpty) {
      order = newOrders.firstWhere(
        (o) => o['id'] == orderId,
        orElse: () => <String, dynamic>{},
      );
    }

    if (order.isNotEmpty) {
      // 1. Add to In Progress
      final inProgressOrder = Map<String, dynamic>.from(order);
      inProgressOrder['status'] = 'قيد التنفيذ';
      inProgressOrder['currentStep'] = 1; // Workflow step
      inProgressOrders.add(inProgressOrder);

      // 2. Remove from New/Latest
      latestOrdersOverview.removeWhere((o) => o['id'] == orderId);
      newOrders.removeWhere((o) => o['id'] == orderId);

      // 3. Navigate to Workflow
      Get.toNamed(Routes.PROVIDER_WORKFLOW, arguments: inProgressOrder);
    } else {
      Get.snackbar('خطأ', 'الطلب غير موجود');
    }
  }

  void rejectOrder(String? orderId) {
    final reasonController = TextEditingController();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'رفض الطلب',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'يرجى كتابة سبب رفض الطلب:',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'سبب الرفض...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (reasonController.text.isNotEmpty) {
                          // Find order to move to rejected
                          var orderToReject = latestOrdersOverview.firstWhere(
                              (o) => o['id'] == orderId,
                              orElse: () => <String, dynamic>{});
                          if (orderToReject.isEmpty) {
                            orderToReject = newOrders.firstWhere(
                                (o) => o['id'] == orderId,
                                orElse: () => <String, dynamic>{});
                          }

                          if (orderToReject.isNotEmpty) {
                            final rejectedOrder =
                                Map<String, dynamic>.from(orderToReject);
                            rejectedOrder['status'] = 'مرفوض';
                            rejectedOrder['rejectionReason'] =
                                reasonController.text;
                            rejectedOrders.add(rejectedOrder);
                          }

                          // Remove the order from display
                          latestOrdersOverview
                              .removeWhere((o) => o['id'] == orderId);
                          // Also remove from newOrders list if present there
                          newOrders.removeWhere((o) => o['id'] == orderId);

                          Get.back(); // Close dialog
                          Get.snackbar(
                            'تم الرفض',
                            'تم نقل الطلب لقائمة المرفوضات',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else {
                          Get.snackbar(
                            'تنبيه',
                            'يرجى كتابة سبب الرفض',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'تأكيد الرفض',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        'إلغاء',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void completeOrder(String? orderId) {
    if (orderId == null) return;

    final index = inProgressOrders.indexWhere((o) => o['id'] == orderId);
    if (index != -1) {
      final order = inProgressOrders[index];

      // 1. Add to Completed Orders
      final completedOrder = Map<String, dynamic>.from(order);
      completedOrder['status'] = 'مكتمل';
      completedOrder['completedDate'] = DateTime.now().toString().split(' ')[0];
      completedOrdersList.add(completedOrder);
      completedOrders.value++; // Increment stats

      // 2. Add to My Reviews (Simulate a review)
      final review = {
        'id': order['id'],
        'jobTitle': order['title'],
        'clientName': order['clientName'] ?? 'عميل',
        'location': order['location'] ?? '',
        'completedDate':
            DateTime.now().toString().split(' ')[0], // Current date
        'rating': 5, // Default 5 stars
        'comment': 'تم إنجاز العمل بنجاح.',
        'price': 0, // Should come from order details
        'icon': order['icon'] ?? Icons.check_circle,
        'iconColor': const Color(0xFF2196F3),
      };
      myReviews.insert(0, review); // Add to top

      // 3. Remove from In Progress
      inProgressOrders.removeAt(index);
    }
  }

  void goToOrderDetails(Map<String, dynamic> order) {
    Get.toNamed(Routes.PROVIDER_ORDER_DETAILS, arguments: order);
  }

  void goToNotifications() {
    Get.toNamed(Routes.NOTIFICATIONS);
  }

  void goToSettings() {
    Get.toNamed(Routes.VENDOR_SETTINGS);
  }

  // Service Management Methods
  void deleteService(int index) {
    if (index >= 0 && index < myServices.length) {
      final serviceName = myServices[index]['title'];
      myServices.removeAt(index);
      Get.snackbar(
        'تم الحذف',
        'تم حذف الخدمة "$serviceName" بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void editService(Map<String, dynamic> service) {
    isEditing.value = true;
    editingServiceId.value = service['id'] ?? '';

    serviceNameController.text = service['title'] ?? '';
    serviceDescriptionController.text = service['description'] ?? '';
    servicePriceController.text = (service['price'] ?? 0).toString();
    selectedRegion.value = service['region'] ?? 'صنعاء';
    selectedImages.clear();
    if (service['image'] != null && !service['image'].contains('assets/')) {
      selectedImages.add(service['image']);
    }

    Get.to(() => const ProviderAddServiceView());
  }

  void addService() {
    if (serviceNameController.text.isEmpty) {
      Get.snackbar(
        'خطأ',
        'يرجى إدخال اسم الخدمة',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (isEditing.value) {
      final index = myServices.indexWhere(
        (s) => s['id'] == editingServiceId.value,
      );
      if (index != -1) {
        myServices[index] = {
          ...myServices[index],
          'title': serviceNameController.text,
          'description': serviceDescriptionController.text,
          'price': double.tryParse(servicePriceController.text) ?? 0,
          'region': selectedRegion.value,
          'image': selectedImages.isNotEmpty
              ? selectedImages.first
              : myServices[index]['image'],
        };
        myServices.refresh();
      }
    } else {
      final newService = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'title': serviceNameController.text,
        'description': serviceDescriptionController.text,
        'price': double.tryParse(servicePriceController.text) ?? 0,
        'image': selectedImages.isNotEmpty
            ? selectedImages.first
            : 'assets/images/product1.png',
        'region': selectedRegion.value,
        'icon': Icons.home_repair_service,
      };
      myServices.add(newService);
    }

    Get.snackbar(
      isEditing.value ? 'تم التحديث' : 'تم الإضافة',
      isEditing.value ? 'تم تحديث الخدمة بنجاح' : 'تم إضافة الخدمة بنجاح',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Reset editing state
    isEditing.value = false;
    editingServiceId.value = '';

    // Clear form
    serviceNameController.clear();
    serviceDescriptionController.clear();
    servicePriceController.clear();
    selectedImages.clear();

    Get.back(); // Navigate back to my services
  }

  void goToWorkflow(Map<String, dynamic> order) {
    Get.toNamed(Routes.PROVIDER_WORKFLOW, arguments: order);
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed(Routes.LOGIN);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('خروج', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void showProfileImageDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'صورة الملف الشخصي',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              CircleAvatar(
                radius: 60.r,
                backgroundColor: const Color(0xFFE8F5E9),
                child: Icon(
                  Icons.eco,
                  size: 50.sp,
                  color: const Color(0xFF4CAF50),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton.icon(
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    'تنبيه',
                    'تم تغيير الصورة بنجاح (محاكاة)',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('تغيير الصورة'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  'إغلاق',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    try {
      final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        Get.snackbar(
          'خطأ',
          'لا يمكن إجراء الاتصال. تأكد من وجود تطبيق للاتصال.',
        );
      }
    } catch (e) {
      Get.snackbar('خطأ', 'حدث خطأ أثناء محاولة الاتصال');
    }
  }

  Future<void> launchWhatsApp(String phoneNumber) async {
    try {
      // Try WhatsApp app first
      final Uri whatsappUrl = Uri.parse('whatsapp://send?phone=$phoneNumber');

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl);
      } else {
        // Fallback to wa.me web link (works on emulators and when WhatsApp not installed)
        final Uri webUrl = Uri.parse('https://wa.me/$phoneNumber');
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Final fallback - try web URL directly
      try {
        final Uri webUrl = Uri.parse('https://wa.me/$phoneNumber');
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      } catch (e2) {
        Get.snackbar(
          'خطأ',
          'لا يمكن فتح واتساب. تأكد من تثبيت التطبيق أو وجود متصفح.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  void callClient() {
    // Dummy implementation replaced by specific methods above
    // keeping this for backward compatibility if needed, calling specific method
    makePhoneCall('966500000000'); // Example number
  }
}
