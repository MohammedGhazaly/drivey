import 'package:drivey_files/widgets/home_screen/home_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(30),
        ),
        body: Column(
          children: [
            HomeHeader(),
          ],
        ));
  }
}
