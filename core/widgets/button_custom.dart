import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_house/app/core/resources/font_manager.dart';
import 'package:my_house/app/core/themes/app_theme.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final bool isLoading;

  const ButtonCustom({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? baseTheme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? baseTheme.colorScheme.onPrimary,
                  ),
                ),
              )
            : Text(
                text,
                style: FontManager.h2_18_700(
                  color: textColor ?? baseTheme.colorScheme.onPrimary,
                ),
              ),
      ),
    );
  }
}
