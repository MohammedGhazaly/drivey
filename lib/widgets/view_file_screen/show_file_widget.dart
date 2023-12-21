import 'package:drivey_files/models/file_model.dart';
import 'package:drivey_files/widgets/view_file_screen/custom_pdf_viewer.dart';
import 'package:drivey_files/widgets/view_file_screen/non_viewable_widget.dart';
import 'package:flutter/material.dart';

class ShowFileWidget extends StatelessWidget {
  final FileModel fileModel;
  const ShowFileWidget({super.key, required this.fileModel});

  @override
  Widget build(BuildContext context) {
    if (fileModel.extenstion == "pdf") {
      return CustomPdfViewer(
        file: fileModel,
      );
    }
    return const NonViewableWidget();
  }
}
