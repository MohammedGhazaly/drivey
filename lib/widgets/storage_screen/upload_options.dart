import 'package:drivey_files/screens/display_files_screen.dart';
import 'package:drivey_files/widgets/storage_screen/colored_container.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:get/get.dart';

class UploadOptions extends StatelessWidget {
  const UploadOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Align(
        alignment: Alignment.center,
        child: Wrap(
          runSpacing: 25,
          spacing: 25,
          children: [
            InkWell(
              onTap: () {
                Get.to(
                    const DisplayFilesScreen(
                      title: "Images",
                      type: "image",
                      folderId: "",
                    ),
                    transition: Transition.leftToRightWithFade);
              },
              child: ColoredContainer(
                color: Colors.lightBlue.withOpacity(0.2),
                icon: const Icon(Icons.image, size: 32, color: Colors.cyan),
                option: "image",
                titel: "Image",
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(
                    const DisplayFilesScreen(
                      title: "Videos",
                      type: "video",
                      folderId: "",
                    ),
                    transition: Transition.leftToRightWithFade);
              },
              child: ColoredContainer(
                color: Colors.pink.withOpacity(0.3),
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
                option: "video",
                titel: "Video",
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(
                    const DisplayFilesScreen(
                      title: "Docs",
                      type: "doc",
                      folderId: "",
                    ),
                    transition: Transition.leftToRightWithFade);
              },
              child: ColoredContainer(
                color: Colors.blue.withOpacity(0.4),
                icon: const Icon(
                  EvaIcons.fileText,
                  size: 32,
                  color: Colors.indigoAccent,
                ),
                option: "docs",
                titel: "docs",
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(
                    const DisplayFilesScreen(
                      title: "Audio",
                      type: "audio",
                      folderId: "",
                    ),
                    transition: Transition.leftToRightWithFade);
              },
              child: ColoredContainer(
                color: Colors.lightBlue.withOpacity(0.2),
                icon: Icon(
                  Icons.music_note_rounded,
                  size: 32,
                  color: Colors.pink.withOpacity(0.6),
                ),
                option: "audio",
                titel: "audio",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
