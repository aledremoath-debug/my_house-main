import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_house/app/core/resources/color_manager.dart';
import 'package:my_house/app/modules/onboarding/views/onboarding_view.dart';
import 'package:my_house/app/routes/app_pages.dart';

import '../../core/resources/assets_manager.dart';
import '../../core/resources/font_manager.dart';
import '../home/views/home_view.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 1500), () {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => const OnboardingView()),
      // );

      Get.offAllNamed(Routes.ONBOARDING);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorManager.splashGradientStart,
                  ColorManager.splashGradientEnd
                ]
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child: Image.asset(
                    IconsAssets.logoIcon,
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
              ),
              Text(
                  "منزلي: خدمات ومتجر",
                style: FontManager.h1_24_700()
              ),
              Text(
                  "كل ما يحتاجه بيتك",
                  style: FontManager.h2_16_400(
                    fontWeight: FontWeight.bold,
                    color: Colors.white70
                  )
              ),
            ],
          ),
        )
      ),
    );
  }
}
