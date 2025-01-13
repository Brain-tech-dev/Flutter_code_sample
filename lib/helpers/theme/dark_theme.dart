import 'package:flutter_demo/utils/global_constants.dart';
import 'package:flutter_demo/utils/color_resources.dart';
import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  fontFamily: GlobalConstants.fontFamily,
  primaryColor: const Color(0xFF689da7),
  shadowColor: ColorResources.black.withOpacity(0.4),
  secondaryHeaderColor: const Color(0xFFaaa818),
  textTheme: const TextTheme(titleLarge: TextStyle(color: Color(0xFF8dbac3)), titleSmall: TextStyle(color: Color(0xFF25282D))),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: ColorResources.black, selectedItemColor: ColorResources.themeDarkBackgroundColor),
);
