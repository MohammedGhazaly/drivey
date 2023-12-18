import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivey_files/core/utils/app_values.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
  }
}
