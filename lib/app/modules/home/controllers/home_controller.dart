import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_house/app/modules/home/models/home_item.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/color_manager.dart';

class HomeController extends GetxController {
  final homeIndex = 0.obs;

  final List<HomeItem> homePage = [
    HomeItem(
      image: IconsAssets.logoIcon1,
      title: "سباكة",
      description:
      "كل ما تحتاجه لصيانة منزلك، من أصغر مسمار الى أكبر قطعة، متاح بسهولة وبجودة عالية، تسوق واستمتع بمنزل متكامل",
      color: ColorManager.blue,
      dotsColor: ColorManager.blue,
      backgroundColor: ColorManager.blue,
      icon: Icons.construction,
    ),
    HomeItem(
      image: IconsAssets.logoIcon2,
      title: "كهربائة",
      description:
      "كل ما تحتاجه لصيانة منزلك، من أصغر مسمار الى أكبر قطعة، متاح بسهولة وبجودة عالية، تسوق واستمتع بمنزل متكامل",
      color: ColorManager.blue,
      dotsColor: ColorManager.blue,
      backgroundColor: ColorManager.blue,
      icon: Icons.electrical_services_outlined,
    ),
    HomeItem(
      image: IconsAssets.logoIcon3,
      title: "أجهزة",
      description:
      "كل ما تحتاجه لصيانة منزلك، من أصغر مسمار الى أكبر قطعة، متاح بسهولة وبجودة عالية، تسوق واستمتع بمنزل متكامل",
      color: ColorManager.blue,
      dotsColor: ColorManager.blue,
      backgroundColor: ColorManager.blue,
      icon: Icons.devices_other,
    ),
    HomeItem(
      image: IconsAssets.logoIcon3,
      title: "تكييف",
      description:
      "كل ما تحتاجه لصيانة منزلك، من أصغر مسمار الى أكبر قطعة، متاح بسهولة وبجودة عالية، تسوق واستمتع بمنزل متكامل",
      color: ColorManager.blue,
      dotsColor: ColorManager.blue,
      backgroundColor: ColorManager.blue,
      icon: Icons.ac_unit_outlined,
    ),
  ];


  void updateIndex(int index) {
    homeIndex.value = index;

  }

}
