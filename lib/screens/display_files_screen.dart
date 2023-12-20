import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivey_files/controllers/files_controller.dart';
import 'package:drivey_files/core/firebase_services/firebase_services.dart';
import 'package:drivey_files/core/utils/app_assets.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:drivey_files/models/file_model.dart';
import 'package:drivey_files/widgets/display_files_screen/download_remove_bottom_sheet.dart';
import 'package:drivey_files/widgets/display_files_screen/files_grid_view.dart';
import 'package:drivey_files/widgets/files_screen/custom_image_widget.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayFilesScreen extends StatelessWidget {
  final String title;
  final String type;
  final String folderId;
  // وتستعمل بقي او بي اكس تحت
  // FilesController filesController = Get.find<FilesController>();
  const DisplayFilesScreen(
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: type == "folder"
              ? FirebaseService.getFilesForSelectedFolder(folderId: folderId)
              : FirebaseService.getFilesAccordingToType(fileType: type),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: const CircularProgressIndicator(
                  color: Colors.deepOrange,
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Column(
                  children: [
                    Text("Couldn't get data, please try again later."),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepOrange,
                      ),
                      onPressed: () {
                        FirebaseService.getFilesForSelectedFolder(
                            folderId: folderId);
                      },
                      child: Text("Try again"),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              List<FileModel> files = [];
              for (var doc in snapshot.data!.docs) {
                files.add(FileModel.fromFireStore(fireStoreData: doc.data()));
              }

              return FilesGridView(
                files: files,
              );
            }
            return SizedBox();
          }),
    );
  }
}
