import 'dart:io';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_demo/utils/common_enums.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_demo/helpers/get_directory.dart';
import 'package:flutter_demo/utils/global_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_demo/network/network_resources.dart';
import 'package:flutter_demo/network/network_endpoints.dart';
import 'package:flutter_demo/network/network_exceptions.dart';

class NetworkManager extends GetxService {
  String? token;
  Map<String, String>? _headers;
  final int timeoutInSeconds = 30;

  final String uniqueId;
  BaseDeviceInfo deiceInfo;
  String baseURL = GlobalConstants.baseUrl;
  final SharedPreferences sharedPreferences;
  NetworkManager({required this.baseURL, required this.uniqueId, required this.deiceInfo, required this.sharedPreferences}) {
    _headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    if (('${deiceInfo.data['isPhysicalDevice']}' == 'true')) {
      _headers!.addAll({
        'device-id': uniqueId,
        'os': GetPlatform.isAndroid ? 'android' : 'ios',
        'device-model': '${deiceInfo.data['brand']} ${deiceInfo.data['model']}'
      });
    }
  }

  void updateHeader({required String token}) {
    _headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    if (('${deiceInfo.data['isPhysicalDevice']}' == 'true')) {
      _headers!.addAll({
        'device-id': uniqueId,
        'os': GetPlatform.isAndroid ? 'android' : 'ios',
        'device-model': '${GetPlatform.isAndroid ? '${deiceInfo.data['brand']} ${deiceInfo.data['device-model']}' : ''} ${deiceInfo.data['model']}'.replaceAll(' null ', ' ')
      });
    }
  }

  Future<dynamic> loadHTTP({required Endpoints endpoint, required HTTPMethod method, Map<String, dynamic>? payload, Map<String, dynamic>? queryParameters, Map<String, String>? multipartPayload, List<MultipartFiles>? multipartFiles}) async {
    if (await isVpnActive()) throw FetchNetworkException(exceptionRawValues[Exceptions.vpnUsageException]);
    final url = Uri.parse(baseURL + endpointRawValues[endpoint]!).replace(queryParameters: queryParameters);
    final payloadJSON = const JsonEncoder.withIndent('  ').convert(payload);

    debugConsole('Request url :: $url');
    debugConsole('Headers $url :: $_headers');
    debugConsole('Payload $url :: $payloadJSON');

    dynamic jsonResponse;
    dynamic httpResponse;

    try {
      switch (method) {
        case (HTTPMethod.get):
          httpResponse = await http.get(url, headers: _headers).timeout(Duration(seconds: timeoutInSeconds));
          break;
        case (HTTPMethod.post):
          httpResponse = await http.post(url, headers: _headers, body: jsonEncode(payload)).timeout(Duration(seconds: timeoutInSeconds));
          break;
        case (HTTPMethod.put):
          httpResponse = await http.put(url, headers: _headers, body: jsonEncode(payload)).timeout(Duration(seconds: timeoutInSeconds));
          break;
        case (HTTPMethod.delete):
          httpResponse = await http.delete(url, headers: _headers, body: jsonEncode(payload)).timeout(Duration(seconds: timeoutInSeconds));
          break;
        case (HTTPMethod.patch):
          httpResponse = await http.patch(url, headers: _headers, body: jsonEncode(payload)).timeout(Duration(seconds: timeoutInSeconds));
          break;
        case (HTTPMethod.multipartPUT):
          httpResponse = await httpMultipart(request: http.MultipartRequest('PUT', url), payload: multipartPayload, files: multipartFiles);
          break;
        case (HTTPMethod.multipartPOST):
          httpResponse = await httpMultipart(request: http.MultipartRequest('POST', url), payload: multipartPayload, files: multipartFiles);
          break;
        default:
      }
      jsonResponse = decodeHTTPResponseBody(httpResponse: httpResponse, endpoint: endpointRawValues[endpoint]!);
    } on SocketException {
      throw FetchNetworkException(exceptionRawValues[Exceptions.timedOutOrNoInternet]);
    }
    return jsonResponse;
  }

  Future<dynamic> httpMultipart({required http.MultipartRequest request, Map<String, String>? payload, List<MultipartFiles>? files}) async {
    if (_headers != null) request.headers.addAll(_headers!);
    for (MultipartFiles file0 in (files ?? [])) {
      if (file0.file != null) {
        File file = File(file0.file!.path);
        request.files.add(http.MultipartFile(file0.key, file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
      }
    }
    if (payload != null) request.fields.addAll(payload);
    http.Response response = await http.Response.fromStream(await request.send()).timeout(Duration(seconds: timeoutInSeconds));
    return response;
  }

  dynamic decodeHTTPResponseBody({required http.Response httpResponse, required String endpoint}) {
    debugConsole('Status code for $endpoint :: ${httpResponse.statusCode}');
    switch (httpResponse.statusCode) {
      case (200):
        try {
          final response = json.decode(httpResponse.body.toString());
          final responseJSON = const JsonEncoder.withIndent('  ').convert(response);
          debugConsole('Response for $endpoint :: $responseJSON');
          return response;
        } catch (_) {
          throw FetchNetworkException(exceptionRawValues[Exceptions.unPreocessableResponse]);
        }
      case (400):
        throw FetchNetworkException(exceptionRawValues[Exceptions.badRequest400]);
      case (401):
        // sessionAlert();
        throw FetchNetworkException(exceptionRawValues[Exceptions.unauthorized401]);
      case (403):
        throw FetchNetworkException(exceptionRawValues[Exceptions.forbidden403]);
      case (404):
        throw FetchNetworkException(exceptionRawValues[Exceptions.requestNotFound404]);
      case (405):
        throw FetchNetworkException(exceptionRawValues[Exceptions.methodNotAllowd405]);
      case (409):
        throw FetchNetworkException(exceptionRawValues[Exceptions.conflictInRequest409]);
      case (500):
        throw FetchNetworkException(exceptionRawValues[Exceptions.serverError500]);
      case (503):
        throw FetchNetworkException(exceptionRawValues[Exceptions.serviceUnavailable503]);
      default:
        throw FetchNetworkException(exceptionRawValues[Exceptions.unknownError000]);
    }
  }
}
