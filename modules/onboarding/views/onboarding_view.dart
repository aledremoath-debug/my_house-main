import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_house/app/core/resources/color_manager.dart';
import 'package:my_house/app/core/resources/font_manager.dart';
import 'package:my_house/app/core/themes/app_theme.dart';

import '../controllers/onboarding_controller.dart';
import '../models/onboarding_item.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Obx(()=>
            controller.currentIndex.value < controller.pages.length -1
            ?Positioned(
              top: 16.h,
              left: 16.w,
              child: TextButton(
                onPressed: controller.skip,
                child: Text(
                  'تخطي',
                  style: FontManager.h2_16_400(
                    color: baseTheme.colorScheme.onSurface.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ):SizedBox(),),
            Column(
              children: [
                SizedBox(height: 80.h),
                Expanded(
                  child: FadeTransition(
                    opacity: controller.fadeAnimation.drive(
                      Tween(begin: 1.0, end: 0.8),
                    ),
                    child: PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.pages.length,
                      onPageChanged: controller.updateIndex,
                      itemBuilder: (context, index) {
                        return _OnBoardingPage(model: controller.pages[index]);
                      },
                    ),
                  ),
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(controller.pages.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        height: 20.h,
                        width:
                            controller.currentIndex.value == index ? 20.w : 20.w,
                        decoration: BoxDecoration(
                          color: controller.currentIndex.value == index
                              ? controller.pages[index].dotsColor
                              : baseTheme.colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 32.h,
                  ),
                  child: Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: controller.currentIndex.value ==
                                  controller.pages.length - 1
                              ? RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                )
                              : RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                          backgroundColor: controller
                              .pages[controller.currentIndex.value]
                              .backgroundColor,
                          elevation: 0,
                        ),
                        onPressed: controller.nextPage,
                        child: Text(
                          controller.currentIndex.value ==
                                  controller.pages.length - 1
                              ? 'ابدأ الآن'
                              : 'التالي',
                          style: FontManager.h2_18_700(
                            color: ColorManager.surface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OnBoardingPage extends StatelessWidget {
  final OnboardingItem model;

  const _OnBoardingPage({required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(
                    model.image,
                    width: 280.w,
                    height: 280.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 280.w,
                        height: 280.w,
                        color: baseTheme.colorScheme.surfaceVariant,
                        child: Icon(
                          Icons.image,
                          size: 50.sp,
                          color: baseTheme.colorScheme.onSurface.withOpacity(
                            0.5,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Text(
            model.title,
            textAlign: TextAlign.center,
            style: FontManager.h1_24_700(
              color: model.color,
            ),
          ),

          Text(
            model.description,
            textAlign: TextAlign.center,
            style: FontManager.h2_16_400(
              color: baseTheme.colorScheme.onSurface.withOpacity(0.7),
            ).copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
