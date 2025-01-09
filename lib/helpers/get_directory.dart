import 'package:flutter_demo/helpers/locale/localization_controller.dart';
import 'package:flutter_demo/screens/dashboard/dashboard_controller.dart';
import 'package:flutter_demo/screens/dashboard/dashboard_repository.dart';
import 'package:flutter_demo/screens/splash/splash_controller.dart';
import 'package:flutter_demo/helpers/theme/theme_controller.dart';
import 'package:flutter_demo/helpers/locale/locale_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/network/network_manager.dart';
import 'package:flutter_demo/utils/global_constants.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'dart:convert';

Future<Map<String, Map<String, String>>> init() async {
  String? uniqueId = await UniqueIdentifier.serial ?? '';
  final sharedPreferences = await SharedPreferences.getInstance();
  final BaseDeviceInfo deviceInfo = await DeviceInfoPlugin().deviceInfo;

  Get.lazyPut(() => uniqueId);
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => deviceInfo);

  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => NetworkManager(baseURL: GlobalConstants.baseUrl, sharedPreferences: Get.find(), uniqueId: Get.find(), deiceInfo: Get.find()));

  // MARK :- CONTROLLERS
  Get.lazyPut(() => SplashController());
  Get.lazyPut(() => DashboardController(repository: Get.find()));

  // MARK :- REPOSITORIES
  Get.lazyPut(() => DashboardRepository(network: Get.find()));

  Map<String, Map<String, String>> languages = {};
  for (LaocaleModel locale in GlobalConstants.languages) {
    String jsonStringLocale = await rootBundle.loadString('assets/language/${locale.localeCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringLocale);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) => json[key] = value.toString());
    languages['${locale.localeCode}_${locale.localeCountryCode}'] = json;
  }
  return languages;
}

void debugConsole(String? message) {
  if (kDebugMode) log(message ?? "null");
}
