import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_house/app/core/resources/color_manager.dart';
import 'package:my_house/app/core/resources/font_manager.dart';
import 'package:my_house/app/core/widgets/button_custom.dart';
import '../../../core/widgets/TextField.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.surface,
      body: SafeArea(
          child:Stack(
            children: [
              Positioned(
                top: -50,
                right: -50,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.blue[300]!,
                        ColorManager.blue[100]!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              // Top Left Blob (Blueish)
              Positioned(
                top: -30,
                left: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        ColorManager.blue[300]!,
                        ColorManager.blue[100]!,
                      ],

                    ),
                  ),
                ),
              ),
              // Bottom Left Blob (Large Cyan)
              Positioned(
                bottom: -100,
                left: -150,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4DD0E1).withOpacity(0.5),
                        ColorManager.blue[700]!,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [

                      const SizedBox(height: 110),

                      Center(
                        child: Text(
                          "أهلأ بعودتك",
                          style: FontManager.h1_40_500(
                            color: ColorManager.bunker,
                          ),
                        ),
                      ),

                      const SizedBox(height: 33),

                      // Login Card
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 33),
                        child: Container(
                          width: double.infinity,
                          height: 335,
                          padding: const EdgeInsets.all(22),
                          decoration: BoxDecoration(
                            color: ColorManager.surface,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: ColorManager.bunker[100]!,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 22),

                              Textfield(
                                textAlign: TextAlign.right,
                                ico: Icon(
                                  Icons.phone_android_outlined,
                                  color: ColorManager.bunker[200],
                                ),
                                titl: "بريد إلكتروني",
                                color: ColorManager.blue[50],
                              ),

                              const SizedBox(height: 22),

                              Textfield(
                                textAlign: TextAlign.right,
                                ico: Icon(
                                  Icons.lock_outline,
                                  color: ColorManager.bunker[200],
                                ),
                                titl: "كلمة المرور",
                                color: ColorManager.blue[50],
                              ),

                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "نسيت كلمة المرور؟",
                                      style: FontManager.h2_16_400(
                                        color: ColorManager.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.blue,
                                  fixedSize: const Size(250, 50),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "تسجيل دخول",
                                  style: FontManager.h2_16_400(
                                    color: ColorManager.background,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      // Bottom Card
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 33),
                        child: Container(
                          height: 53,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: ColorManager.bunker[100]!,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(onPressed: (){},
                                  child: Text(
                                    "إنشاء حساب",
                                    style: FontManager.h2_16_400(
                                      color: ColorManager.blue,
                                    ),
                                  ),
                                ),
                                Text(
                                    "ليس لديك حساب؟"
                                ),
                              ],
                            )

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ),
    );
  }
}

