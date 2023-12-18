import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivey_files/core/utils/app_values.dart';
import 'package:drivey_files/models/folder_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:firebase_core/firebase_core.dart';

class FoldersFilesController extends GetxController {
  RxList<FolderModel> foldersList = <FolderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
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
