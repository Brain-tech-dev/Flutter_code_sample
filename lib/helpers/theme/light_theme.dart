import 'package:flutter_demo/utils/global_constants.dart';
import 'package:flutter_demo/utils/color_resources.dart';
import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  fontFamily: GlobalConstants.fontFamily,
  primaryColorDark: ColorResources.black,
  primaryColor: const Color(0xFF003E47),
  secondaryHeaderColor: const Color(0xFFCFEC7E),
  shadowColor: ColorResources.shadowColor,
  textTheme: const TextTheme(titleLarge: TextStyle(color: Color(0xFF003E47)), titleSmall: TextStyle(color: Color(0xFF25282D))),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: ColorResources.white, selectedItemColor: ColorResources.themeLightBackgroundColor),
);
