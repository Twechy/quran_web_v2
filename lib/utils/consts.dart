import 'package:flutter/material.dart';

import 'common.dart';

class AppConst {
  static Color mainColor = HexColor('7C5F31');
  static Color secondaryColor = HexColor('FF9f1c');
  static Color secondaryRedColor = HexColor('D90429');
  static Color backgroundColor = HexColor('FDF1E2');

  static Color secondaryLightColor = HexColor('FFD9A3');

  static String fontFamily = 'hafs';
  static String fontPackage = 'google_fonts_arabic';

  static ThemeData buildThemeData() {
    return ThemeData(
        primaryColor: AppConst.mainColor,
        primaryColorDark: AppConst.backgroundColor,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: AppConst.secondaryRedColor,
        ));
  }
}
