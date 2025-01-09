import 'package:flutter_demo/screens/dashboard/dashboard_data.dart';
import 'package:flutter_demo/network/network_exceptions.dart';
import 'package:flutter_demo/network/network_endpoints.dart';
import 'package:flutter_demo/network/network_response.dart';
import 'package:flutter_demo/network/network_manager.dart';
import 'package:flutter_demo/helpers/get_directory.dart';
import 'package:flutter_demo/utils/common_enums.dart';
import 'package:get/get.dart';

class DashboardRepository extends GetxController implements GetxService {
  final NetworkManager network;
  DashboardRepository({required this.network});

  Future<void> getHomeData(Function(Result result, NetworkResponse<HomeData>? response, String? message) completion) async {
    try {
      final networkResponse = await network.loadHTTP(endpoint: Endpoints.home, method: HTTPMethod.get);
      try {
        final response = NetworkResponse.fromJson(networkResponse, (json) => HomeData.fromJson(json));
        completion((response.success == true) ? Result.onSuccess : Result.onFailed, response, response.message);
      } catch (e) {
        debugConsole("Exception :: ${e.toString()}");
        throw FetchNetworkException(exceptionRawValues[Exceptions.handShakeError]);
      }
    } catch (exception) {
      completion(Result.onException, null, exception.toString());
      rethrow;
    }
  }
}
