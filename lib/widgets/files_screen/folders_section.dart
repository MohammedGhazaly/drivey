import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivey_files/controllers/files_controller.dart';
import 'package:drivey_files/controllers/upload_folder_controller.dart';
import 'package:drivey_files/core/firebase_services/firebase_services.dart';
import 'package:drivey_files/core/utils/app_assets.dart';
import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:drivey_files/screens/display_files_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoldersSection extends StatelessWidget {
  const FoldersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GetX<FilesAndFolderController>(builder: (controller) {
        if (controller != null && controller.foldersList != null) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.foldersList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(
                      DisplayFilesScreen(
                        title: controller.foldersList[index].folderName,
                        type: "folder",
                        folderId: controller.foldersList[index].id,
                      ),
                      transition: Transition.leftToRightWithFade);
                  // دي طريقة البايندينج كده انا اول مادخل السكرينه
                  // الكونترولر بيبقي شغال واقدر اجيب الداتا مباشرة
                  // علشان مايشهلهاش من الميموري لازم تعمل الطريقه دي
                  // Get.to(
                  //   ()=>  DisplayFilesScreen(
                  //       title: controller.foldersList[index].folderName,
                  //       type: "folder",
                  //       folderId: controller.foldersList[index].id,
                  //     ),
                  //     binding: FilesBinding(
                  //         type: "folder",
                  //         folderId: controller.foldersList[index].id,
                  //         isFolder: true),
                  //     transition: Transition.leftToRightWithFade);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          offset: const Offset(10, 10),
                          blurRadius: 5),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.asset(
                          AppAssets.folderPath,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        controller.foldersList[index].folderName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.textStyle(
                          fontSize: 12,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseService.getFoldersSnapShot(
                              folderId: controller.foldersList[index].id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                "${snapshot.data?.docs.length ?? 0} files",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.textStyle(
                                  fontSize: 10,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            } else {
                              return Text(
                                "0 files",
                                style: AppStyles.textStyle(
                                  fontSize: 10,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }
                          })
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      }),
    );
  }
}
