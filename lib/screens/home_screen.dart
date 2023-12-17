import 'package:drivey_files/controllers/custom_tab_controller.dart';
import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:drivey_files/screens/files_screen.dart';
import 'package:drivey_files/widgets/files_screen/files_screen_modal_bottom_sheet_widget.dart';
import 'package:drivey_files/widgets/home_screen/home_header.dart';
import 'package:drivey_files/screens/storage_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CustomTabController tabController =
      Get.put<CustomTabController>(CustomTabController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
            GetBuilder<CustomTabController>(builder: (controller) {
          return controller.tab != "storage"
              ? FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return FilesScreenModalBottomSheetWidget();
                        });
                  },
                  child: Icon(
                    EvaIcons.folderAdd,
                  ),
                )
              : SizedBox();
        }),
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.deepOrange,
              ),
            ),
          ),
          preferredSize: Size.fromHeight(30),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              GetBuilder<CustomTabController>(builder: (controller) {
                return controller.tab == "storage"
                    ? StorageScreen()
                    : FilesScreen();
              }),
            ],
          ),
        ));
  }
}
