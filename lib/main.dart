import 'package:flutter_demo/helpers/locale/localization_controller.dart';
import 'package:flutter_demo/helpers/get_directory.dart' as directory;
import 'package:flutter_demo/helpers/locale/locale_translation.dart';
import 'package:flutter_demo/helpers/theme/theme_controller.dart';
import 'package:flutter_demo/helpers/theme/light_theme.dart';
import 'package:flutter_demo/helpers/theme/dark_theme.dart';
import 'package:flutter_demo/utils/global_constants.dart';
import 'package:flutter_demo/helpers/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(RentalAndBusinessTax(init: await directory.init()));
}

class RentalAndBusinessTax extends StatelessWidget {
  final Map<String, Map<String, String>>? init;
  const RentalAndBusinessTax({super.key, required this.init});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizationController) {
        return GetMaterialApp(
          navigatorKey: Get.key,
          getPages: RouteHelper.routes,
          title: GlobalConstants.appName,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.noTransition,
          initialRoute: RouteHelper.getSplashRoute(),
          locale: localizationController.locale,
          theme: themeController.darkTheme ? dark : light,
          translations: LocaleTranslation(init: init),
          transitionDuration: const Duration(milliseconds: 250),
          fallbackLocale: Locale(GlobalConstants.languages[0].localeCode!, GlobalConstants.languages[0].localeCountryCode),
        );
      });
    });
  }
}
