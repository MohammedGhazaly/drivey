import 'package:cloud_firestore/cloud_firestore.dart';

class FolderModel {
  late final String id;

  late final String folderName;
  late final Timestamp dateCreated;
  late final int itemsCount;

  FolderModel(
      {required this.id,
      required this.folderName,
      required this.dateCreated,
      required this.itemsCount});

  FolderModel.fromDocumentSnapShot(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    id = doc.id;
    folderName = doc["name"];
    dateCreated = doc["date_created"];
  }
}
