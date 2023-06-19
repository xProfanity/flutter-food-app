import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  _Index createState() => _Index();
}

class _Index extends State<Index> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo() async {
    _videoController = VideoPlayerController.asset('assets/pizza.mp4')
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.setVolume(0);
        _videoController.play();
      });
  }

  Widget _videoBackground() {
    if (_videoController.value.isInitialized) {
      return SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            height: _videoController.value.size.height,
            width: _videoController.value.size.width,
            child: VideoPlayer(_videoController),
          ),
        ),
      );
    } else {
      return SizedBox.expand(
        child: Container(
          child: Image.asset('assets/slashio.jpg', fit: BoxFit.cover),
        ),
      );
    }
  }

  Widget authButton(isGoogle) {
    return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Color(isGoogle ? 0xFF232323 : 0xFFFFFFFF)),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(16.0),
            ),
            fixedSize: MaterialStateProperty.all<Size>(const Size(220, 50))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset('assets/${isGoogle ? 'google' : 'facebook'}.png'),
            const SizedBox(
              width: 22,
            ),
            Text(
              "Sign In With ${isGoogle ? 'google' : 'facebook'}",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(isGoogle ? 0xFFFFFFFF : 0xFF1877F2)),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(children: <Widget>[
        _videoBackground(),
        Center(
          child: Column(
            verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Hello :)",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 100,
              ),
              authButton(true),
              const SizedBox(
                height: 15,
              ),
              authButton(false),
            ],
          ),
        ),
      ]),
    ));
  }
}
