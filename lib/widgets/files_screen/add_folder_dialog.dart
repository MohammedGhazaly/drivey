import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drivey_files/controllers/upload_folder_controller.dart';
import 'package:drivey_files/core/firebase_services/firebase_services.dart';
import 'package:drivey_files/core/singeltons/connectivity_singelton.dart';
import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddFolderDialog extends StatefulWidget {
  const AddFolderDialog({super.key});

  @override
  State<AddFolderDialog> createState() => _AddFolderDialogState();
}

class _AddFolderDialogState extends State<AddFolderDialog> {
  late TextEditingController folderNameController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    folderNameController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    folderNameController.dispose();
  }

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
          onPressed: () async {
            if (folderNameController.text.trim().isNotEmpty) {
              final connectionResult =
                  await ConnectivitySingelton.checkInternet();
              if (connectionResult == ConnectivityResult.none) {
                return;
              }
              await FirebaseService.uploadFolder(
                  name: folderNameController.text);
              if (!context.mounted) return;
              Navigator.pop(context);
            }
          },
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
        controller: folderNameController,
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
