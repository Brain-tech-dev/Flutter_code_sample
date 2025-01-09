import 'package:flutter_demo/helpers/locale/locale_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/utils/global_constants.dart';
import 'package:flutter_demo/utils/local_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalizationController extends GetxController {
  final SharedPreferences sharedPreferences;
  LocalizationController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  Locale _locale = Locale(GlobalConstants.languages[0].localeCode!, GlobalConstants.languages[0].localeCountryCode);
  Locale get locale => _locale;
  List<LaocaleModel> _languages = [];
  List<LaocaleModel> get languages => _languages;

  Future<int> loadCurrentLanguage() async {
    _locale = Locale(sharedPreferences.getString(LocalKeys.localeCode) ?? GlobalConstants.languages[0].localeCode!, sharedPreferences.getString(LocalKeys.localeCountryCode) ?? GlobalConstants.languages[0].localeCountryCode);
    for (int index = 0; index < GlobalConstants.languages.length; index++) {
      if (GlobalConstants.languages[index].localeCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(GlobalConstants.languages);
    update();
    return _selectedIndex;
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(LocalKeys.localeCode, locale.languageCode);
    sharedPreferences.setString(LocalKeys.localeCountryCode, locale.countryCode!);
  }

  void setSelectIndex(int index, {isUpdate = true}) {
    _selectedIndex = index;
    if (isUpdate) update();
  }
}
