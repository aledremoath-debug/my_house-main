import 'package:flutter/material.dart';

class ColorManager {
  static const Color transparent = Colors.transparent;
  static const int _primaryColor = 0xFF2EA5C6;

  static const MaterialColor primary =
  MaterialColor(_primaryColor, <int, Color>{
     50: Color(0xFFE1F4F8),
      100: Color(0xFFB4E4ED),
      200: Color(0xFF82D3E1),
      300: Color(0xFF50C2D5),
      400: Color(0xFF2AB5CC),
      500: Color(_primaryColor),
      600: Color(0xFF289DB8),
      700: Color(0xFF20899F),
      800: Color(0xFF187587),
      900: Color(0xFF0C5260),
  });

  static const int _secondaryColor = 0xFF75D7E6;

  static const MaterialColor secondary =
      MaterialColor(_secondaryColor, <int, Color>{
       50: Color(0xFFE8F9FC),
      100: Color(0xFFC9F0F7),
      200: Color(0xFFAAE7F1),
      300: Color(0xFF8BDDEB),
      400: Color(0xFF76D6E7),
      500: Color(_secondaryColor),
      600: Color(0xFF6AC2D0),
      700: Color(0xFF58A9B6),
      800: Color(0xFF46809A),
      900: Color(0xFF2E5670),
      });

  static const int _blueColor = 0xFF2196F3;

  static const MaterialColor blue =
  MaterialColor(_blueColor, <int, Color>{
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A5F5),
    500: Color(_blueColor),
    600: Color(0xFF1E88E5),
    700: Color(0xFF1976D2),
    800: Color(0xFF1565C0),
    900: Color(0xFF0D47A1),
  });

  static const int _grayShadesColor = 0xFF7A7A7A;

  static const MaterialColor grayShades =
  MaterialColor(_grayShadesColor, <int, Color>{
    50: Color(0xFFF6F6F6),
    100: Color(0xFFE7E7E7),
    200: Color(0xFFD1D1D1),
    300: Color(0xFFB0B0B0),
    400: Color(0xFF888888),
    500: Color(_grayShadesColor),
    600: Color(0xFF5D5D5D),
    700: Color(0xFF4F4F4F),
    800: Color(0xFF454545),
    900: Color(0xFF3D3D3D),
    950: Color(0xFF262626),
  });

  static const int _snowColor = 0xFFfbfbfb;

  static const MaterialColor snow = MaterialColor(_snowColor, <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFCFCFC),
    400: Color(0xFFFCFCFC),
    500: Color(_snowColor),
    600: Color(0xFFE0CACA),
    700: Color(0xFFBA8C8C),
    800: Color(0xFF965A5A),
    900: Color(0xFF703232),
    950: Color(0xFF471515),
  });

  static const int _dustyGreyColor = 0xFF878787;

  static const MaterialColor dustyGrey =
  MaterialColor(_dustyGreyColor, <int, Color>{
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF2F2F2),
    200: Color(0xFFE0E0E0),
    300: Color(0xFFCFCFCF),
    400: Color(0xFFABABAB),
    500: Color(_dustyGreyColor),
    600: Color(0xFF7A6E6E),
    700: Color(0xFF664D4D),
    800: Color(0xFF523131),
    900: Color(0xFF3D1C1C),
    950: Color(0xFF260B0B),
  });

  static const int _slateGreyColor = 0xFF262626;

  static const MaterialColor slateGrey =
  MaterialColor(_slateGreyColor, <int, Color>{
    50: Color(0xFFF5F5F5),
    100: Color(0xFFEBEBEB),
    200: Color(0xFFC9C9C9),
    300: Color(0xFFA8A8A8),
    400: Color(0xFF696969),
    500: Color(_slateGreyColor),
    600: Color(0xFF242020),
    700: Color(0xFF1C1515),
    800: Color(0xFF170E0E),
    900: Color(0xFF120808),
    950: Color(0xFF0A0303),
  });

  static const int _gluonGreyColor = 0xFF1B1B1E;

  static const MaterialColor gluonGrey =
  MaterialColor(_gluonGreyColor, <int, Color>{
    50: Color(0xFFF5F5F5),
    100: Color(0xFFE7E6E8),
    200: Color(0xFFC4C3C7),
    300: Color(0xFFA19FA6),
    400: Color(0xFF5B5A61),
    500: Color(_gluonGreyColor),
    600: Color(0xFF17171C),
    700: Color(0xFF0F0F17),
    800: Color(0xFF0A0A12),
    900: Color(0xFF05050D),
    950: Color(0xFF020208),
  });


  static const int _bunkerColor = 0xFF151419;

  static const MaterialColor bunker =
  MaterialColor(_bunkerColor, <int, Color>{
    50: Color(0xFFF4F2F5),
    100: Color(0xFFE6E3E8),
    200: Color(0xFFC2BDC7),
    300: Color(0xFF9C96A3),
    400: Color(0xFF55515E),
    500: Color(_bunkerColor),
    600: Color(0xFF121117),
    700: Color(0xFF0C0B12),
    800: Color(0xFF09070F),
    900: Color(0xFF05040A),
    950: Color(0xFF030208),
  });




  
  static const background = Color(0xFFF9FAFB);
  static const surface = Color(0xFFFFFFFF);

  static const button = Color(0xFF1CA1C1);

  static const error = Color(0xFFE53935);
  static const primaryDark = Color(0xFF0C2A3E);

  static const splashGradientStart = Color(0xFF0061A8);
  static const splashGradientEnd = Color(0xFF00B7C3);
}
