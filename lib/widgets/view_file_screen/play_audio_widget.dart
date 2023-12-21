import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:drivey_files/widgets/view_file_screen/custom_audio_controls.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PlayAudioWidget extends StatefulWidget {
  final String url;
  final String name;
  const PlayAudioWidget({super.key, required this.url, required this.name});

  @override
  State<PlayAudioWidget> createState() => _PlayAudioWidgetState();
}

class _PlayAudioWidgetState extends State<PlayAudioWidget> {
  late AudioPlayer audioPlayer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer = AudioPlayer()..setUrl(widget.url);
  }

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream, (position, bufferedPosition, duration) {
        return PositionData(
            position: position,
            bufferedPosition: bufferedPosition,
            duration: duration ?? Duration.zero);
      });

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: StreamBuilder(
              stream: positionDataStream,
              builder: ((context, snapshot) {
                final positionData = snapshot.data;
                return ProgressBar(
                  timeLabelTextStyle: TextStyle(
                    height: 2,
                  ),
                  progress: positionData?.position ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                  buffered: positionData?.bufferedPosition ?? Duration.zero,
                  onSeek: audioPlayer.seek,
                );
              }),
            ),
          ),
          CustomAudioControls(
            audioPlayer: audioPlayer,
          )
        ],
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(
      {required this.position,
      required this.bufferedPosition,
      required this.duration});
}
