import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class AppHelpersFunctions {
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
}
