import 'dart:async';

import 'package:anato/controllers/actividadesControll.dart';
import 'package:anato/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController _controller;
  var rq = new RestPrincipalRequest();
  VoidCallback listener;
  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
    initializeVideo();
    _controller.play();

    ///video splash display only 5 second you can change the duration according to your need
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 12);
    return new Timer(_duration, navigationPage);
  }

  void initializeVideo() {
    _controller = VideoPlayerController.asset('assets/videoPrincipal.mp4')
      ..addListener(listener)
      ..initialize()
      ..play();
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(listener);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    super.dispose();
  }

  Future<void> navigationPage() async {
    await rq.infoNecesaria().then((value) {
      _controller.setVolume(0.0);
      _controller.removeListener(listener);
      Navigator.of(context).pushReplacementNamed("/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: <Widget>[
          new AspectRatio(
              aspectRatio: 6 / 11,
              child: Container(
                child: (_controller != null
                    ? VideoPlayer(
                        _controller,
                      )
                    : Container()),
              )),
        ]),
      ),
      bottomNavigationBar: footer(context),
    );
  }
}
