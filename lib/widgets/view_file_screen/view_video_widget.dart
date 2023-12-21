import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ViewVideoWidget extends StatefulWidget {
  final String url;
  const ViewVideoWidget({super.key, required this.url});

  @override
  State<ViewVideoWidget> createState() => _ViewVideoWidgetState();
}

class _ViewVideoWidgetState extends State<ViewVideoWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController? chewieController;

  @override
  void initState() {
    initilizeController();
    super.initState();

    // videoPlayerController =
    //     VideoPlayerController.networkUrl(Uri.parse(widget.url));
    // videoPlayerController.initialize().whenComplete(() {
    //   chewieController = ChewieController(
    //       videoPlayerController: videoPlayerController,
    //       autoPlay: true,
    //       looping: false);
    // });
    // // videoPlayerController.initialize().then((value) {
    // //   chewieController = ChewieController(
    // //       videoPlayerController: videoPlayerController,
    // //       autoPlay: true,
    // //       looping: false);
    // // });
    // // initilizeController();
    // isInitilized = true;
    // setState(() {});
  }

  Future<void> initilizeController() async {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url));
    await videoPlayerController.initialize();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
    chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chewieController == null) {
      return Center(
        child: const CircularProgressIndicator(
          color: Colors.deepOrange,
        ),
      );
    } else {
      return Chewie(controller: chewieController!);
    }

    // isInitilized == true
    //     ? Chewie(controller: chewieController)
    //     : Center(
    //         child: const CircularProgressIndicator(
    //           color: Colors.deepOrange,
    //         ),
    //       );
  }
}
