import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivey_files/core/utils/app_values.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

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
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    // Getting the file paths and adding them to List
    if (result != null) {
      for (var path in result.paths) {
        files.add(File(path!));
      }

      // Getting filetype, fileName and extension
      for (var file in files) {
        String? fileType = lookupMimeType(file.path);
        // Getting filetype for example image
        String? filteredFileType = fileType!.split("/")[0];

        List<String?> pathParts = file.path.split("/");
        String? fileName = pathParts.last;
        String? extenstion = fileName?.split(".").last;
        File compressedFile = await compressImage(file, filteredFileType);
        if (filteredFileType == "image") {
          print("sssssssssss");
          print(compressedFile);
        }
        // Getting compressed Files
        // print(compressedFile);
      }
    }
  }

  // Compress files function
  static Future<File> compressImage(File file, String fileType) async {
    Uuid uuid = Uuid();
    String randomStrng = uuid.v4();

    Directory directory = await getTemporaryDirectory();
    String targetPath = directory.path + "/${randomStrng}.jpg";
    XFile? result = await FlutterImageCompress.compressAndGetFile(
        file.path, targetPath,
        quality: 70);
    return File(result!.path);

    // else if (fileType == "video") {}
  }
}
