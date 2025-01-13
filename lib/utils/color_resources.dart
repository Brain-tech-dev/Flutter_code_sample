import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorResources {
  // MARK:- _
  static Color grey = Colors.grey;
  static Color error = Colors.red;
  static Color black = Colors.black;
  static Color white = Colors.white;
  static Color success = Colors.green;
  static Color black54 = Colors.black54;
  static Color clear = Colors.transparent;

  // MARK:- THEME
  static Color theme = const Color(0xFFFF8024); // CHANGABLE
  static Color themeDarkBackgroundColor = const Color(0xFF343636);
  static Color themeLightBackgroundColor = const Color(0xFFFAFAFA);

  // MARK:- ASSETS
  static Color shadowColor = grey.withOpacity(0.4);
  static Color dividerColor = const Color(0xFFADADAD);
  static Color textPlaceholder = const Color(0xFFE0E0E0);

  // MARK:- _
  static Color? getIconColor() => Get.isDarkMode ? white : null;
  static Color getBlackAndWhite() => Get.isDarkMode ? black : white;
  static Color getWhiteAndBlack() => Get.isDarkMode ? white : black;
  static Color getWhiteBackground() => Get.isDarkMode ? textPlaceholder : white;
  static Color getGreyBackground() => Get.isDarkMode ? black54 : textPlaceholder;
  static Color getBackgroundColor(BuildContext context) => Theme.of(context).cardColor;

  static Color? getWhiteIconDarkColor() => Get.isDarkMode ? Colors.white : null;
}
