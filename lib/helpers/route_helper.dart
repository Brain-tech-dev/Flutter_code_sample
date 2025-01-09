import 'package:flutter_demo/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_demo/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String _splashScreen = '/splash_screen';
  static const String _dashboardScreen = '/dashboard_screen';

  static getSplashRoute() => _splashScreen;
  static getDashboardRoute() => _dashboardScreen;

  static List<GetPage> routes = [
    GetPage(name: _splashScreen, page: () => const SplashScreen()),
    GetPage(name: _dashboardScreen, page: () => const DashboardScreen()),
  ];
}

void present(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    CupertinoPageRoute(fullscreenDialog: true, builder: (context) => widget),
  );
}

void presentWithoutAnimationTo(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => widget,
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
    ),
  );
}
