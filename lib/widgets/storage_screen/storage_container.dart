import 'package:drivey_files/controllers/storage_controller.dart';
import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StorageContainer extends StatelessWidget {
  const StorageContainer({super.key});

  getSize(int size) {
    if (size < 1000) {
      return "${size} KB";
    } else if (size < 1000000) {
      int sizeMb = (size * 0.001).round();
      return "${sizeMb} MB";
    } else {
      int sizeGB = (size * 0.000001).round();
      return "${sizeGB} GB";
    }
  }

  @override
  Widget build(BuildContext context) {
    final StorageController storageController = Get.put(StorageController());

    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.01),
              offset: const Offset(10, 10),
              blurRadius: 10),
          BoxShadow(
            color: Colors.grey.withOpacity(0.01),
            offset: const Offset(-10, 10),
            blurRadius: 10,
          ),
        ]),
        child: Obx(() {
          print(storageController.totaleSize.value);
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 25, bottom: 35),
                child: Column(
                  children: [
                    CircularPercentIndicator(
                      radius: 100,
                      lineWidth: 20,
                      percent: 0.5,
                      progressColor: Colors.deepOrange,
                      backgroundColor: Colors.deepOrange.shade100,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 10)
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ((storageController.totaleSize.value /
                                                1000000) *
                                            100)
                                        .round()
                                        .toString(),
                                    style: AppStyles.textStyle(
                                        fontSize: 28,
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "%",
                                    style: AppStyles.textStyle(
                                        fontSize: 20,
                                        color: AppColors.textColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Text(
                                "Used",
                                style: AppStyles.textStyle(
                                    fontSize: 20,
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Used",
                                  style: AppStyles.textStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.textColor
                                          .withOpacity(0.75)),
                                ),
                                Text(
                                  getSize(storageController.totaleSize.value),
                                  style: AppStyles.textStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.textColor),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                color: AppColors.textColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Free",
                                  style: AppStyles.textStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.textColor
                                          .withOpacity(0.75)),
                                ),
                                Text(
                                  "1 GB",
                                  style: AppStyles.textStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.textColor),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
