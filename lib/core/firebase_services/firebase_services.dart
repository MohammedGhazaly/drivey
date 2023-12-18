import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivey_files/core/utils/app_values.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

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

  static uploadFile({required String folderId}) async {
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
        late File compressedFile;

        if (filteredFileType == "image") {
          compressedFile = await compressImage(file);
        } else if (filteredFileType == "video") {
          compressedFile = await compressVideo(file);
        } else {
          compressedFile = file;
        }

        int length = await AppValues.userCollection
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("files")
            .get()
            .then((value) => value.docs.length);
        //  Uploading file to storage
        // log("FileType: ${fileType}");
        // log("filteredFileType: ${filteredFileType}");
        // log("pathParts: ${pathParts}");
        // log("fileName: ${fileName}");
        // log("extenstion: ${extenstion}");
        // log("compressedFile: ${compressedFile}");
        Get.snackbar("Uploading file.", "This my take sometime, please wait.",
            duration: Duration(seconds: 15));
        await uploadToFireStorage(
            file: compressedFile,
            length: length,
            type: fileType,
            fileName: fileName!,
            filteredFileType: filteredFileType,
            extenstion: extenstion!,
            folderId: folderId,
            fileSize: ((compressedFile.readAsBytesSync()).lengthInBytes / 1024)
                .round());
        Get.closeCurrentSnackbar();
        Get.snackbar("File uploaded.", "Thank your for your patience.");
      }
    }
  }

  // Compress files function
  static Future<File> compressImage(File file) async {
    try {
      Uuid uuid = Uuid();
      String randomStrng = uuid.v4();

      Directory directory = await getTemporaryDirectory();

      String targetPath = directory.path + "/${randomStrng}.jpg";
      XFile? result = await FlutterImageCompress.compressAndGetFile(
          file.path, targetPath,
          quality: 50);
      return File(result!.path);
    } catch (e) {
      return file;
    }

    // else if (fileType == "video") {}
  }

  static Future<File> compressVideo(File file) async {
    try {
      MediaInfo? info = await VideoCompress.compressVideo(file.path,
          quality: VideoQuality.MediumQuality,
          deleteOrigin: false,
          includeAudio: true);
      return info!.file!;
    } catch (e) {
      return file;
    }
  }

  static Future<void> uploadToFireStorage({
    required File file,
    required int length,
    required String type,
    required String fileName,
    required String filteredFileType,
    required String extenstion,
    required String folderId,
    required int fileSize,
  }) async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("files")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child("File $length: $fileName")
        .putFile(file, SettableMetadata(contentType: type));
    // uploadTask.snapshotEvents.listen((event) {
    //   print(object);
    // });
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String fileUrl = await taskSnapshot.ref.getDownloadURL();
    // Saving data in firestore for each user
    await saveDataInFireStare(
        fileUrl: fileUrl,
        fileName: fileName,
        filteredFileType: filteredFileType,
        extenstion: extenstion,
        folderId: folderId,
        fileSize: fileSize);
  }

  static saveDataInFireStare({
    required String fileUrl,
    required String fileName,
    required String filteredFileType,
    required String extenstion,
    required String folderId,
    required int fileSize,
  }) async {
    await AppValues.userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("files")
        .add({
      "file_url": fileUrl,
      "file_name": fileName,
      "file_type": filteredFileType,
      "file_extenstion": extenstion,
      // TODO => We will change this later
      "folder_id": "L2Puohu08DZT5Q4tl6h3",
      "file_size": fileSize,
      "date_uploaded": FieldValue.serverTimestamp(),
    });
  }
}
