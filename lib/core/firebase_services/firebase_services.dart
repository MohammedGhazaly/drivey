import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivey_files/core/utils/app_values.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mime/mime.dart';

class FirebaseService {
  static Future<void> uploadFolder({required String name}) async {
    DocumentReference<Map<String, dynamic>> userFolder = await AppValues
        .userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("folders")
        .add({"name": name, "date_created": FieldValue.serverTimestamp()});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getFoldersSnapShot(
      {required String folderId}) async* {
    yield* AppValues.userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("files")
        .where("folder_id", isEqualTo: folderId)
        .snapshots();
  }

  static uploadFile({required String folderName}) async {
    List<File> files = [];
    List<String?> fileTypes = [];
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      for (var path in result.paths) {
        files.add(File(path!));
      }

      for (var file in files) {
        String? fileType = lookupMimeType(file.path);
        fileTypes.add(fileType?.split("/")[0]);
        List<String?> pathParts = file.path.split("/");
        String? fileName = pathParts.last;
        String? extenstion = fileName?.split(".").last;
        print(fileName);
        print(extenstion);
      }
    }
  }
}
