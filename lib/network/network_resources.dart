import 'dart:io';

class MultipartFiles {
  String key;
  File? file;
  MultipartFiles(this.key, this.file);
}

Future<bool> isVpnActive() async {
  bool isVpnActive;
  List<NetworkInterface> interfaces = await NetworkInterface.list(includeLoopback: false, type: InternetAddressType.any);
  interfaces.isNotEmpty ? isVpnActive = interfaces.any((interface) => interface.name.contains("tun") || interface.name.contains("ppp") || interface.name.contains("pptp")) : isVpnActive = false;
  return isVpnActive;
}
