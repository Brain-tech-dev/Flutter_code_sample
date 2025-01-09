import 'package:flutter_demo/screens/splash/splash_controller.dart';
import 'package:flutter_demo/utils/color_resources.dart';
import 'package:flutter_demo/utils/local_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    Get.find<SplashController>().route();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(LocalImages.logo, height: size.height, width: size.width, fit: BoxFit.cover, color: ColorResources.getWhiteIconDarkColor()),
          ],
        ),
      ),
    );
  }
}
