import 'package:flutter_demo/components/label.dart';
import 'package:flutter_demo/screens/dashboard/dashboard_controller.dart';
import 'package:flutter_demo/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/common_enums.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    Get.find<DashboardController>().getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getBackgroundColor(context),
      // appBar: ADD YOUR APP BAR HERE
      // bottomNavigationBar: ADD YOUR BOTTOM NAVIGATION BAR HERE
      body: const Center(child: Label(text: "Hey, Flutter !!", style: TextStyleType.semibold)),
    );
  }
}
