import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  final String extenstion;
  final String fileType;
  final String url;
  const CustomImageWidget({
    super.key,
    required this.extenstion,
    required this.fileType,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    print(url);
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: fileType == "image"
            ? CachedNetworkImage(
                fit: BoxFit.cover,
                width: 75,
                imageUrl: url,
              )
            : Image.asset(
                "assets/images/${extenstion}.png",
                fit: BoxFit.cover,
                width: 75,
              ),
      ),
    );
  }
}
