import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_house/app/core/resources/color_manager.dart';
import 'package:my_house/app/routes/app_pages.dart';

import '../../../core/resources/assets_manager.dart';
import '../models/onboarding_item.dart';

class OnboardingController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late PageController pageController;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  final currentIndex = 0.obs;

  final List<OnboardingItem> pages = [
    OnboardingItem(
      image: IconsAssets.logoIcon1,
      title: "قطع غيارك المنزلية، بلمسة زر",
      description:
          "كل ما تحتاجه لصيانة منزلك، من أصغر مسمار الى أكبر قطعة، متاح بسهولة وبجودة عالية، تسوق واستمتع بمنزل متكامل",
      color: ColorManager.blue,
      dotsColor: ColorManager.blue,
      backgroundColor: ColorManager.blue,
    ),
    OnboardingItem(
      image: IconsAssets.logoIcon2,
      title: "خدمات منزلية في متناول يدك",
      description:
          "كل ما تحتاجه لصيانة منزلك، من أصغر مسمار الى أكبر قطعة، متاح بسهولة وبجودة عالية، تسوق واستمتع بمنزل متكامل",
      color: ColorManager.gluonGrey[950]!,
      dotsColor: ColorManager.splashGradientEnd,
      backgroundColor: ColorManager.splashGradientEnd,
    ),
    OnboardingItem(
      image: IconsAssets.logoIcon3,
      title: "تتبع الطلبات",
      description:
          "كل ما تحتاجه لصيانة منزلك، من أصغر مسمار الى أكبر قطعة، متاح بسهولة وبجودة عالية، تسوق واستمتع بمنزل متكامل",
      color: ColorManager.dustyGrey[950]!,
      dotsColor: ColorManager.splashGradientEnd,
      backgroundColor: ColorManager.splashGradientEnd,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    animationController.forward();
  }

  void updateIndex(int index) {
    currentIndex.value = index;
    animationController.reset();
    animationController.forward();
  }

  void nextPage() {
    if (currentIndex.value == pages.length - 1) {
      _completeOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    Get.offAllNamed(Routes.MAIN);
  }

  @override
  void onClose() {
    pageController.dispose();
    animationController.dispose();
    super.onClose();
  }
}
