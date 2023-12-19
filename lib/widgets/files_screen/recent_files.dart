import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivey_files/controllers/upload_folder_controller.dart';
import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Recent files",
            textAlign: TextAlign.left,
            style: AppStyles.textStyle(
              fontSize: 14,
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GetX<FilesAndFolderController>(builder: (controller) {
            return SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.recentFiles.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 75,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageWidget(
                            extenstion:
                                controller.recentFiles[index].extenstion,
                            fileType: controller.recentFiles[index].type,
                            url: controller.recentFiles[index].url,
                          ),
                          // constSizedBox(height: 3,),
                          Text(
                            controller.recentFiles[index].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppStyles.textStyle(
                                fontSize: 10, color: AppColors.textColor),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class CustomImageWidget extends StatelessWidget {
  final String extenstion;
  final String fileType;
  final String url;
  const CustomImageWidget({
    super.key,
    required this.extenstion,
    required this.fileType,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    print(url);
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: fileType == "image"
            ? CachedNetworkImage(
                fit: BoxFit.cover,
                width: 75,
                imageUrl: url,
              )
            : Image.asset(
                "assets/images/${extenstion}.png",
                fit: BoxFit.cover,
                width: 75,
              ),
      ),
    );
  }
}
