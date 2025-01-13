import 'package:flutter_demo/helpers/route_helper.dart';
import 'package:get/get.dart';

class SplashController extends GetxController implements GetxService {
  void route() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.toNamed(RouteHelper.getDashboardRoute());
    });
  }
}
