import 'package:drivey_files/controllers/auth_controller.dart';
import 'package:drivey_files/screens/home_screen.dart';
import 'package:drivey_files/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootScreen extends StatelessWidget {
  RootScreen({super.key});
  final AuthController authController =
      Get.put<AuthController>(AuthController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return authController.user.value == null
          ? LoginScreen()
          : const HomeScreen();
    });
  }
}
