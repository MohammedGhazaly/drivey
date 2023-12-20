import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:drivey_files/models/file_model.dart';
import 'package:drivey_files/screens/view_file_screen.dart';
import 'package:drivey_files/widgets/display_files_screen/download_remove_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilesGridView extends StatelessWidget {
  final List<FileModel> files;
  const FilesGridView({super.key, required this.files});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
          itemCount: files.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(ViewFileScreen(file: files[index]),
                    transition: Transition.zoom);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: files[index].type == "image"
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: files[index].url,
                            )
                          : Image.asset(
                              "assets/images/${files[index].extenstion}.png",
                              fit: BoxFit.cover,
                              // width: 75,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          files[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.textStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      InkWell(
                        overlayColor:
                            MaterialStateProperty.resolveWith((states) {
                          return Colors.transparent;
                        }),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return DownloadRemoveBottomSheet(
                                  fileName: files[index].name.split(".")[0],
                                );
                              });
                        },
                        child: Icon(
                          Icons.more_vert,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
