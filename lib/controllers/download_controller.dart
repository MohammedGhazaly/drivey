import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drivey_files/models/file_model.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadController extends GetxController {
  bool isDownloading = false;
  Future<void> downloadFile(FileModel file) async {
    try {
      log("s");
      isDownloading = true;
      update();
      final downloadPath = await getDownloadPath();
      final path = "${downloadPath}/${file.name.replaceAll(" ", "")}";
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      await Dio().download(file.url, path);
      log(path);
    } catch (e) {
      isDownloading = false;
      update();
      if (e is DioException) {
        log(e.message!);
      }
      log(e.toString());
    }
    isDownloading = false;
    update();
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      print(err);
    }
    return directory?.path;
  }
}
