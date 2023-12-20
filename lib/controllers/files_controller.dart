import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivey_files/core/utils/app_values.dart';
import 'package:drivey_files/models/file_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FilesController extends GetxController {
  final String type;
  final String folderId;
  final bool isFolder;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  RxList<FileModel> files = <FileModel>[].obs;
  FilesController({
    required this.type,
    required this.folderId,
    required this.isFolder,
  });

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (isFolder == false) {
    } else {
      files.bindStream(AppValues.userCollection
          .doc(userId)
          .collection("files")
          .where("folder_id", isEqualTo: folderId)
          .snapshots()
          .map(
        (QuerySnapshot<Map<String, dynamic>> data) {
          List<FileModel> tempFiles = [];
          for (var doc in data.docs) {
            var file = FileModel.fromFireStore(fireStoreData: doc.data());
            tempFiles.add(file);
          }
          return tempFiles;
        },
      ));
      ;
    }
  }
}

// REMEMBER
// ممكن نحط البايندينج في سكرينه معينه
// ومش هتعمل انيشيلز للكونترولر الا أول ماتروح لها
class FilesBinding extends Bindings {
  final String type;
  final String folderId;
  final bool isFolder;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  RxList<FileModel> files = <FileModel>[].obs;

  FilesBinding(
      {required this.type, required this.folderId, required this.isFolder});
  @override
  void dependencies() {
    Get.lazyPut<FilesController>(() {
      return FilesController(
          type: type, folderId: folderId, isFolder: isFolder);
    });
  }
}
