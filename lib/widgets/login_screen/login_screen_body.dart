import 'package:drivey_files/controllers/auth_controller.dart';
import 'package:drivey_files/core/utils/app_assets.dart';
import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Spacer(),
          Image.asset(
            AppAssets.folderPath,
            width: 150,
            height: 150,
            // fit: BoxFit.cover,
          ),
          Spacer(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(right: 30, left: 30, bottom: 30),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 5,
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Simplify your",
                  style: AppStyles.textStyle(
                      fontSize: 18,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Filing systems",
                  style: AppStyles.textStyle(
                      fontSize: 18,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Keep your files organized more easily",
                  textAlign: TextAlign.center,
                  style: AppStyles.textStyle(
                      fontSize: 16,
                      color: AppColors.textColorLight,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      backgroundColor: Colors.deepOrangeAccent.withOpacity(0.8),
                    ),
                    onPressed: () async {
                      await Get.find<AuthController>().login();
                    },
                    child: Text(
                      "Let's go",
                      style: AppStyles.textStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
