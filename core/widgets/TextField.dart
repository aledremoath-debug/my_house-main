import 'package:flutter/material.dart';
import 'package:my_house/app/core/resources/color_manager.dart';
import 'package:my_house/app/core/resources/font_manager.dart';

class Textfield extends StatelessWidget {
  final TextEditingController? TextController;
  final TextAlign textAlign;
  final Color? color;
  final String? titl;
  final Widget? ico;
  const Textfield({
    this.TextController,
    required this.textAlign,
    required this.color,
    required this.titl,
    this.ico,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        textAlign: textAlign,
        decoration: InputDecoration(
          hintText: titl,
          hintStyle: FontManager.h2_16_400(
            color: ColorManager.bunker[200]
        ),
          suffixIcon: ico,
          filled: true,
          fillColor: color,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                  color: ColorManager.blue
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                  color: ColorManager.blue
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(
                  color: ColorManager.blue
              )
          ),

        ),
      ),
    );
  }
}
