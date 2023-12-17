import 'package:drivey_files/controllers/auth_controller.dart';
import 'package:drivey_files/widgets/login_screen/login_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.deepPurple,
          Colors.deepPurpleAccent,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: LoginScreenBody(),
      ),
    );
  }
}
