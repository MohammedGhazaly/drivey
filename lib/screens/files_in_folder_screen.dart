import 'package:drivey_files/core/firebase_services/firebase_services.dart';
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
    );
  }
}
