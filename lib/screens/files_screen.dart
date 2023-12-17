import 'package:drivey_files/widgets/files_screen/recent_files.dart';
import 'package:flutter/material.dart';

class FilesScreen extends StatelessWidget {
  const FilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 32,
        ),
        RecentFiles()
      ],
    );
  }
}
