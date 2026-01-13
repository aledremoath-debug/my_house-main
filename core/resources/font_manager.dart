import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_theme.dart';

class FontManager {
  static const String defaultFontFamily = 'Tajawal';

  static TextStyle h1_50_500({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 50.sp,
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1.33,
  );

  static TextStyle h1_40_500({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 40.sp,
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1.33,
  );

  static TextStyle h1_32_500({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 32.sp,
    fontWeight: fontWeight ?? FontWeight.w500,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1.60,
  );

  static TextStyle h1_28_600({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 28.sp,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1.50,
  );

  static TextStyle h1_26_600({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 26.sp,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1.50,
  );

  static TextStyle h1_24_700({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 24.sp,
    fontWeight: fontWeight ?? FontWeight.w700,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1.50,
  );

  static TextStyle h2_22_700({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 22.sp,
    fontWeight: fontWeight ?? FontWeight.w700,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
  );

  static TextStyle h2_20_600({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 20.sp,
    fontWeight: fontWeight ?? FontWeight.w600,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1.60,
  );

  static TextStyle h2_18_700({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 18.sp,
    fontWeight: fontWeight ?? FontWeight.w700,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1.20,
  );

  static TextStyle h2_16_400({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 16.sp,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
  );

  static TextStyle h2_14_400({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 14.sp,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1.71,
  );

  static TextStyle h3_12_400({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 12.sp,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1,
  );

  static TextStyle h3_10_400({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 10.sp,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1.60,
  );

  static TextStyle h3_8_400({
    Color? color,
    String? fontFamily,
    FontWeight? fontWeight,
  }) => TextStyle(
    fontSize: 8.sp,
    fontWeight: fontWeight ?? FontWeight.w400,
    color: color ?? baseTheme.colorScheme.onSecondary,
    fontFamily: fontFamily ?? defaultFontFamily,
    height: 1.60,
  );
}
