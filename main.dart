import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_house/app/routes/app_pages.dart';
import 'app/data/services/vendor_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        Get.put(VendorService()); // Initialize Global Service
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          initialRoute: Routes.PROVIDER_DASHBOARD, // الصفحة الأولى
          getPages: AppPages.routes,
        );
      },
    );
  }
}
