import 'package:drivey_files/controllers/custom_tab_controller.dart';
import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:drivey_files/widgets/home_screen/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        children: [
          Text(
            "Drivey",
            style: AppStyles.textStyle(
              fontSize: 28,
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Google drive clone",
            style: AppStyles.textStyle(
                fontSize: 18,
                color: AppColors.textColor,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4),
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade100,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      offset: const Offset(10, 10),
                      blurRadius: 10),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    offset: const Offset(-10, 10),
                    blurRadius: 10,
                  ),
                  // BoxShadow()
                ]),
            child: GetBuilder<CustomTabController>(builder: (controller) {
              return Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      controller.changeTab("storage");
                    },
                    child: CustomTabBar(
                      text: "Storage",
                      isSelected: controller.tab == "storage",
                    ),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      controller.changeTab("files");
                    },
                    child: CustomTabBar(
                        text: "Files", isSelected: controller.tab == "files"),
                  )),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
