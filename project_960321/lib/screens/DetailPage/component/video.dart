import 'package:flutter/material.dart';
import 'package:project_960321/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoYoutubeNaja extends StatefulWidget {
  const VideoYoutubeNaja({Key? key, required this.url}) : super(key: key);
  final String url;
  @override
  State<VideoYoutubeNaja> createState() => _VideoYoutubeNajaState(url: url);
}

class _VideoYoutubeNajaState extends State<VideoYoutubeNaja> {
  late YoutubePlayerController _controller;
  _VideoYoutubeNajaState({required this.url});
  final String url;

  @override
  void initState() {
    super.initState();

    String url = this.url.substring(30);

    _controller = YoutubePlayerController(
      initialVideoId: url,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_controller.initialVideoId);

    return Container(
      child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: kPrimaryColor,
          progressColors: ProgressBarColors(
            playedColor: kPrimaryColor,
            handleColor: kPrimaryColor,
          ),
          onReady: () {
            _controller.addListener(() {});
          }),
    );
  }
}
