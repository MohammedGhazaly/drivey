import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivey_files/core/utils/app_values.dart';
import 'package:drivey_files/models/file_model.dart';
import 'package:drivey_files/models/folder_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:firebase_core/firebase_core.dart';

class FilesAndFolderController extends GetxController {
  RxList<FolderModel> foldersList = <FolderModel>[].obs;
  RxList<FileModel> recentFiles = <FileModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    recentFiles.bindStream(AppValues.userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("files")
        .orderBy("date_uploaded", descending: true)
        .limit(25)
        .snapshots()
        .map((querySnapShot) {
      final List<FileModel> files = [];
      for (var doc in querySnapShot.docs) {
        files.add(FileModel.fromFireStore(fireStoreData: doc.data()));
        print(files);
      }
      return files;
    }));

    foldersList.bindStream(
      AppValues.userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("folders")
          .orderBy("date_created", descending: true)
          .snapshots()
          .map((querySnapShot) {
        final List<FolderModel> folders = [];

        for (var doc in querySnapShot.docs) {
          folders.add(FolderModel.fromDocumentSnapShot(doc));
        }
        return folders;
      }),
    );
  }
}
