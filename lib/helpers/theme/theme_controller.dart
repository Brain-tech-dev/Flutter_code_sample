import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/utils/local_keys.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  final SharedPreferences sharedPreferences;
  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences.setBool(LocalKeys.theme, _darkTheme);
    update();
  }

  void _loadCurrentTheme() async {
    _darkTheme = sharedPreferences.getBool(LocalKeys.theme) ?? false;
    update();
  }
}
