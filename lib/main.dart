import 'package:flutter/material.dart';
import 'package:news_app/home.dart';
import 'package:news_app/components/splash/ImageSplashScreen.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatefulWidget {

	State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State {
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'NEWS WATCH',
			theme: ThemeData(
				primaryColor: Color.fromARGB(255, 254, 85, 106),
			),
//			initialRoute: Home.rName,
			home: ImageSplashScreen(),
			routes: {
				Home.routeName: (context) {
					return Home();
				}
			},
		);
	}
}
