import 'package:flutter_demo/screens/dashboard/dashboard_repository.dart';
import 'package:flutter_demo/screens/dashboard/dashboard_data.dart';
import 'package:flutter_demo/utils/common_enums.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController implements GetxService {
  final DashboardRepository repository;
  DashboardController({required this.repository});
  HomeData? homeData;

  Future<void> getHomeData() async {
    await repository.getHomeData((result, response, message) {
      switch (result) {
        case Result.onSuccess:
          homeData = response?.data;
          break;
        case Result.onFailed:
          break;
        case Result.onException:
          break;
      }
    });
  }
}
