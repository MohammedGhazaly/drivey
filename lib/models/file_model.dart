class FileModel {
  late final String fileId;
  late final String folderId;
  late final String url;
  late final String name;
  late final String extenstion;
  late final String type;
  late final int size;
  // late final DateTime dateUploaded;

  FileModel({
    required this.name,
    required this.fileId,
    required this.folderId,
    required this.url,
    required this.type,
    required this.extenstion,
    required this.size,
    // required this.dateUploaded
  });
  factory FileModel.fromFireStore(
      {required Map<String, dynamic> fireStoreData}) {
    return FileModel(
      name: fireStoreData["file_name"],
      fileId: fireStoreData["file_id"],
      folderId: fireStoreData["folder_id"],
      url: fireStoreData["file_url"],
      type: fireStoreData["file_type"],
      extenstion: fireStoreData["file_extenstion"],
      size: fireStoreData["file_size"],
      // dateUploaded: fireStoreData["date_uploaded"],
    );
  }
}
