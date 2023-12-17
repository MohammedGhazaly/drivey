import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilesScreenModalBottomSheetWidget extends StatelessWidget {
  const FilesScreenModalBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AddFolderDialog();
                  });
            },
            child: Row(
              children: [
                Icon(EvaIcons.folder, color: AppColors.textColor),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Folder",
                  style: AppStyles.textStyle(
                      fontSize: 14,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(EvaIcons.upload, color: AppColors.textColor),
              SizedBox(
                width: 10,
              ),
              Text(
                "Upload",
                style: AppStyles.textStyle(
                    fontSize: 14,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AddFolderDialog extends StatelessWidget {
  const AddFolderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            // Get.back();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.textColor),
          onPressed: () {},
          child: Text("Add folder"),
        ),
      ],
      title: Text(
        "New folder",
        style: AppStyles.textStyle(
          fontSize: 14,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        autofocus: true,
        style: AppStyles.textStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: "Folder name",
          hintStyle: AppStyles.textStyle(
            fontSize: 12,
            color: AppColors.textColor.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
