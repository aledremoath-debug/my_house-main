import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:my_house/app/core/resources/color_manager.dart';
import 'package:my_house/app/core/resources/font_manager.dart';
import 'package:my_house/app/modules/login/views/login_view.dart';

import '../../../core/themes/app_theme.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Icon(
                         Icons.location_on_outlined,
                         color: ColorManager.bunker,
                         size: 28,
                       ),
                       Row(
                         children: [
                           TextButton(onPressed: (){
                             Get.to(()=> LoginView());
                           },
                               child: Text(
                                 "تسجيل دخول",
                                 style: FontManager.h1_24_700(
                                     color: ColorManager.bunker
                                 ),
                               ),
                           ),
                           SizedBox(width: 120.w,),
                           Icon(
                             Icons.add_alert_outlined,
                             color: ColorManager.bunker,
                             size: 28,
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorManager.surface,
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'أبحث',
                        hintStyle: FontManager.h3_12_400(
                          color: ColorManager.bunker
                        ),
                        prefixIcon: Icon(
                            Icons.search_rounded,
                          color:ColorManager.primary[300],
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(
                            color: ColorManager.background
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(
                            color: ColorManager.background
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(
                              color: ColorManager.background
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(
                              color: ColorManager.background
                          ),
                        ),
                      ),
                    ),
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Container(
                    width: double.infinity,
                    height: 200.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorManager.bunker[100]!,
                          ColorManager.grayShades.shade400,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child:
                    PageView.builder(
                      controller: pageController,
                      itemCount: controller.homePage.length,
                      onPageChanged: controller.updateIndex,
                      itemBuilder: (context, index) {
                        final item = controller.homePage[index];
                        return AnimatedBuilder(
                          animation: pageController,
                          builder: (context, child) {
                            double value = 0;
                            if (pageController.position.haveDimensions) {
                              value = pageController.page! - index;
                              value = (value * 50).clamp(-50, 50); // تحريك الصور
                            }
                            return Transform.translate(
                              offset: Offset(value, 0),
                              child: child,
                            );
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 20,
                                left: 70,
                                child: Image.asset(
                                  item.image,
                                  width: 180.w,
                                  height: 180.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 60.w,
                                right: 0.w,
                                child: Text(item.title),
                              ),
                              Positioned(
                                bottom: 30.w,
                                right: 0.w,
                                child: Text(item.description),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 130,
                                child:  Obx(
                                      () => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                    List.generate(controller.homePage.length, (i) {
                                      return AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                                        height: 10.h,
                                        width: controller.homeIndex.value == i ? 10.w : 10.w,
                                        decoration: BoxDecoration(
                                          color: controller.homeIndex.value == i
                                              ? controller.homePage[i].dotsColor
                                              : baseTheme.colorScheme.surfaceVariant,
                                          borderRadius: BorderRadius.circular(20.r),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "أقسام الخدمات",
                        style: FontManager.h1_24_700(
                            color: ColorManager.bunker
                        ),
                      ),
                    ],
                  ),
                ), //أقسام الخدمات
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SizedBox(
                    child:  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 60,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: controller.homePage.length,
                      itemBuilder: (context, index) {
                        final itemC = controller.homePage[index];
                        return Container(
                          padding:  EdgeInsets.symmetric(horizontal: 18.w),
                          decoration: BoxDecoration(
                            color: ColorManager.surface,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: ColorManager.bunker[100]!, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                itemC.icon,
                                color: ColorManager.primary[300],
                              ),
                              SizedBox(width: 10.w,),
                              Text(
                                itemC.title,
                                style: FontManager.h2_18_700(
                                  color: ColorManager.bunker,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ), //GridView.builder أقسام الخدمات
                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "الأكثر طلبًا",
                        style: FontManager.h1_24_700(
                            color: ColorManager.bunker
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          print("object");
                        },
                        child: Text(
                          "عرض الكل",
                          style: FontManager.h2_16_400(
                            color: ColorManager.primary[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                ), //الأكثر طلبًا
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SizedBox(
                    height: 200.h,
                    child:  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.homePage.length,
                      itemBuilder: (context, index) {
                        final itemC = controller.homePage[index];
                        return Row(
                          children: [
                            Container(
                              padding:  EdgeInsets.symmetric(horizontal: 18.w,vertical: 10.h),
                              decoration: BoxDecoration(
                                color: ColorManager.surface,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: ColorManager.bunker[100]!, width: 1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    itemC.image,
                                    width: 120,
                                  ),
                                  /// النص
                                  Text(
                                    itemC.title,
                                    style: FontManager.h2_18_700(
                                      color: ColorManager.bunker,
                                    ),
                                  ),
                                  SizedBox(width: 10.w,),
                                  Icon(
                                    itemC.icon,
                                    color: ColorManager.primary[300],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15.w),
                          ],
                        );
                      },
                    ),
                  ),
                ), //ListView.builder الأكثر طلبًا
                SizedBox(height: 20.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "فنيون مميزون",
                        style: FontManager.h1_24_700(
                            color: ColorManager.bunker
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          print("object");
                        },
                        child: Text(
                          "عرض الكل",
                          style: FontManager.h2_16_400(
                            color: ColorManager.primary[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // فنيون مميزون
                SizedBox(height: 10.h,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SizedBox(
                    height: 200.h,
                    child:  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.homePage.length,
                      itemBuilder: (context, index) {
                        final itemC = controller.homePage[index];
                        return Row(
                          children: [
                            Container(
                              width:200,
                              padding:  EdgeInsets.symmetric(horizontal: 18.w,vertical: 10.h),
                              decoration: BoxDecoration(
                                color: ColorManager.surface,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: ColorManager.bunker[100]!, width: 1),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  CircleAvatar(
                                    child: Image.asset(
                                        itemC.image,
                                      width: double.infinity,
                                    ),
                                    radius: 40,
                                  ),
                                  /// النص
                                  Text(
                                    itemC.title,
                                    style: FontManager.h2_18_700(
                                      color: ColorManager.bunker,
                                    ),
                                  ),
                                  SizedBox(width: 10.w,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          "4.0",
                                        style: FontManager.h2_16_400(
                                          color: ColorManager.bunker
                                        ),
                                      ),
                                      Icon(
                                        Icons.star_border_outlined,
                                        color:Colors.yellow
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(width: 15.w),
                          ],
                        );
                      },
                    ),
                  ),
                ), //ListView.builder فنيون مميزون
              ],
            ),
          )
      )
    );
  }
}


// final ScrollController scrollController = ScrollController();
// Timer.periodic(Duration(seconds: 3), (timer) {
// if (scrollController.hasClients) {
// double maxScroll = scrollController.position.maxScrollExtent;
// double currentScroll = scrollController.offset;
// double nextScroll = currentScroll + 200; // مقدار التمرير لكل عنصر
// if (nextScroll >= maxScroll) {
// scrollController.jumpTo(0); // العودة للبداية
// } else {
// scrollController.animateTo(
// nextScroll,
// duration: Duration(milliseconds: 500),
// curve: Curves.easeInOut,
// );
// }
// }
// });