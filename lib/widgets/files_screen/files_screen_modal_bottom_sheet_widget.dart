import 'package:drivey_files/core/firebase_services/firebase_services.dart';
import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:drivey_files/widgets/files_screen/add_folder_dialog.dart';
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
                    return const AddFolderDialog();
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
          InkWell(
            onTap: () async {
              await FirebaseService.uploadFile(folderName: "");
            },
            child: Row(
              children: [
                Icon(EvaIcons.fileAdd, color: AppColors.textColor),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "File",
                  style: AppStyles.textStyle(
                      fontSize: 14,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
