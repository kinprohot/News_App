import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Detail extends StatefulWidget {
	static const String rName = 'detail';
	final String title;
	final String content;

	const Detail(this.title, this.content, {Key? key}) : super(key: key);

	@override
	State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
	late WebViewController _controller;

	@override
	void initState() {
		super.initState();
		_controller = WebViewController()
			..setJavaScriptMode(JavaScriptMode.unrestricted)
			..loadRequest(Uri.parse(widget.content));
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text(widget.title)),
			body: WebViewWidget(controller: _controller),
		);
	}
}
