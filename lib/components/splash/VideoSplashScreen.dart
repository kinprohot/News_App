import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoSplashScreen extends StatefulWidget {
	@override
	VideoState createState() => VideoState();
}

class VideoState extends State<VideoSplashScreen> {
	late VideoPlayerController playerController;
	late VoidCallback listener;

	@override
	@override
	void initState() {
		super.initState();
		listener = () {
			setState(() {});
		};
		initializeVideo();
		playerController.play();

		///video splash display only 5 second you can change the duration according to your need
		startTime();
	}

	startTime() async {
		var _duration = new Duration(seconds: 7);
		return new Timer(_duration, navigationPage);
	}

	void navigationPage() {
		playerController.setVolume(0.0);
		playerController.removeListener(listener);
		Navigator.of(context).pushReplacementNamed('home');
	}

	void initializeVideo() {
		playerController =
		VideoPlayerController.asset('assets/videos/splash.mp4')
			..addListener(listener)
			..setVolume(1.0)
			..initialize()
			..play();
	}

	@override
	void deactivate() {
		if (playerController != null) {
			playerController.setVolume(0.0);
			playerController.removeListener(listener);
		}
		super.deactivate();
	}

	@override
	void dispose() {
		// TODO: implement dispose
		if (playerController != null) playerController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Stack(fit: StackFit.expand, children: <Widget>[
				new AspectRatio(
					aspectRatio: 9 / 16,
					child: Container(
						child: (playerController != null
							? VideoPlayer(
							playerController,
						)
							: Container()),
					)),
			]));
	}
}
