import 'package:flutter_demo/helpers/locale/locale_model.dart';

extension GlobalConstants on String {
  // MARK:- ASSETS
  static String appName = 'RENTAL & BUSINESS TAX';
  static String baseUrl = 'ADD_YOUR_BASE_URL_HERE';

  // MARK:- FONT FAMILIES
  static String fontFamily = 'Rubik';

  // MARK:- LANGUAGES
  static List<LaocaleModel> languages = [
    LaocaleModel(imageUrl: null, localeName: 'English', localeCountryCode: 'US', localeCode: 'en'),
    LaocaleModel(imageUrl: null, localeName: 'Arabic', localeCountryCode: 'SA', localeCode: 'ar'),
  ];
}
