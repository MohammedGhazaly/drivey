import 'package:drivey_files/core/utils/app_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StorageController extends GetxController {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  RxInt totaleSize = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    getStorage();
  }

  getStorage() {
    totaleSize.bindStream(AppValues.userCollection
        .doc(userId)
        .collection("files")
        .snapshots()
        .map((file) {
      int size = 0;
      for (var doc in file.docs) {
        // size += doc.data()["file_size"] as int;
        size += doc["file_size"] as int;
      }
      print(size);
      return size;
    }));
  }
}
