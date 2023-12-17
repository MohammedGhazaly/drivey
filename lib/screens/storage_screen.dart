import 'package:drivey_files/widgets/storage_screen/storage_container.dart';
import 'package:drivey_files/widgets/storage_screen/upload_options.dart';
import 'package:flutter/material.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          StorageContainer(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.1,
          ),
          UploadOptions()
        ],
      ),
    );
  }
}
