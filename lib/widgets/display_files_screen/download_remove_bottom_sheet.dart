import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class DownloadRemoveBottomSheet extends StatelessWidget {
  final String fileName;
  const DownloadRemoveBottomSheet({super.key, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fileName),
          SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(EvaIcons.download),
                SizedBox(
                  width: 6,
                ),
                Text("Download"),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Icon(EvaIcons.fileRemove),
                SizedBox(
                  width: 6,
                ),
                Text("Remove"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
