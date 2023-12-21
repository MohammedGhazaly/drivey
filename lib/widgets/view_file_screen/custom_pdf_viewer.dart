import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:drivey_files/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CustomPdfViewer extends StatefulWidget {
  final FileModel file;
  const CustomPdfViewer({super.key, required this.file});

  @override
  State<CustomPdfViewer> createState() => _CustomPdfViewerState();
}

class _CustomPdfViewerState extends State<CustomPdfViewer> {
  late File pdfFile;
  bool pdfInitilized = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initilizePdf();
  }

  initilizePdf() async {
    pdfFile = await loadPdfFile(widget.file);
    pdfInitilized = true;
    setState(() {});
  }

  Future<File> loadPdfFile(FileModel file) async {
    final response = await http.get(Uri.parse(file.url));
    // Convert to bytes
    final bytes = response.bodyBytes;
    return storeFile(file, bytes);
  }

  Future<File> storeFile(FileModel file, Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    log(directory.toString());
    final fileName = File("${directory.path}/${file.name}");
    print(fileName.path);
    await fileName.writeAsBytes(bytes, flush: true);
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    return pdfInitilized == true
        ? PDFView(
            filePath: pdfFile.path,
            fitEachPage: false,
          )
        : Center(
            child: const CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          );
  }
}
