import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';


import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: PersistentTabView(
        context,
        controller: controller.tabController,
        screens: controller.pages,
        items: controller.navBarsItems(),
        backgroundColor: Colors.white,
        decoration: NavBarDecoration(
          colorBehindNavBar: Colors.white,
        ),
        // navBarStyle: NavBarStyle.style1,
      ),
    );

  }
}
