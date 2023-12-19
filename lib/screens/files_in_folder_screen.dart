import 'package:drivey_files/core/firebase_services/firebase_services.dart';
import 'package:drivey_files/core/utils/app_assets.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:drivey_files/widgets/files_screen/custom_image_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class FilesInFolderScreen extends StatelessWidget {
  final String title;
  final String type;
  final String folderId;
  const FilesInFolderScreen(
      {super.key,
      required this.title,
      required this.type,
      required this.folderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type == "folder" ? "$title (Folder)" : title),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () async {
          await FirebaseService.uploadFile(folderId: folderId);
        },
        child: Icon(
          EvaIcons.fileAdd,
          color: Colors.white,
        ),
      ),
      body: FilesGridView(),
    );
  }
}

class FilesGridView extends StatelessWidget {
  const FilesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemBuilder: (context, index) {
            return Container(
              // margin: EdgeInsets.all(6),
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // CustomImageWidget(
                  //   extenstion: extenstion,
                  //   fileType: fileType,
                  //   url: url,
                  // )
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/images/doc.png",
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
                          "Image one",
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
                        onTap: () {},
                        child: Icon(
                          Icons.more_vert,
                        ),
                      )
                      // Icon(Icons.oval)
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
