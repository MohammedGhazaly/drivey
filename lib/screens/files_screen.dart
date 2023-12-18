import 'package:drivey_files/controllers/upload_folder_controller.dart';
import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:drivey_files/widgets/files_screen/folders_section.dart';
import 'package:drivey_files/widgets/files_screen/recent_files.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilesScreen extends StatelessWidget {
  FilesScreen({super.key});
  final FoldersFilesController uploadFolderController =
      Get.put(FoldersFilesController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        const RecentFiles(),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Folders",
            textAlign: TextAlign.left,
            style: AppStyles.textStyle(
              fontSize: 14,
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        FoldersSection()
      ],
    );
  }
}
