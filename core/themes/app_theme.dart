import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../resources/color_manager.dart';

class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: ColorManager.secondary.shade900,
      primary: ColorManager.primary,
      secondary: ColorManager.primary.shade200,
      surface: ColorManager.primary.shade900,
      onPrimary: ColorManager.snow,
      onSecondary: ColorManager.bunker,
      onSurface: ColorManager.secondary.shade900,
      brightness: Brightness.light,
      error: Colors.redAccent,
      surfaceVariant: ColorManager.grayShades.shade200,
      tertiary: ColorManager.primary.shade400,
    );
    return ThemeData(
      scaffoldBackgroundColor: ColorManager.primary.shade50,
      brightness: Brightness.light,
      primaryColor: ColorManager.secondary.shade800,
      colorScheme: colorScheme,
      primarySwatch: Colors.grey,
      secondaryHeaderColor: ColorManager.secondary.shade800,
      canvasColor: Colors.transparent,
    );
  }

  static bool get tabletWidth => 1.sw > 600;

  static TextTheme getBaseTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  static ThemeData baseTheme(BuildContext context) {
    return Theme.of(context);
  }
}

ThemeData get baseTheme => Get.theme;

TextTheme get getBaseTheme => Get.textTheme;
