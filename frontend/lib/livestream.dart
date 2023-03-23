import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:video_player/video_player.dart';

class LiveStream extends StatelessWidget {
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width * 0.72;
    double height = screenSize.height * 0.5;

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: -1,
              blurRadius: 16,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.white54),
                    gradient: LinearGradient(
                      begin: const Alignment(-0.05, -1),
                      end: const Alignment(0.05, 1),
                      colors: <Color>[
                        const Color.fromARGB(255, 23, 67, 143).withOpacity(0.1),
                        const Color.fromARGB(255, 176, 205, 255)
                            .withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Live",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Center(
                          child: SizedBox(
                              height: height * 0.9,
                              width: width * 0.9,
                              child: PlayVideoFromNetwork()),
                        )
                      ]),
                ))));
  }
}

class PlayVideoFromNetwork extends StatefulWidget {
  const PlayVideoFromNetwork({Key? key}) : super(key: key);

  @override
  State<PlayVideoFromNetwork> createState() => _PlayVideoFromNetworkState();
}

late final PodPlayerController controller;

class _PlayVideoFromNetworkState extends State<PlayVideoFromNetwork> {
  bool playing = false;
  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.asset(
        'assets/clip.mov',
      ),
    )..initialise();
    super.initState();
    controller.addListener(checkVideo);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(controller: controller);
  }

  void checkVideo() {
    // Implement your calls inside these conditions' bodies :
    if (controller.isVideoPlaying && !playing) {
      playing = true;
      print('video playing');
    } else if (!controller.isVideoPlaying && playing) {
      playing = false;
      print("video paused");
    }
  }
}
