import 'package:flutter/material.dart';

class StateFulWrapper extends StatefulWidget {
	final Function onInit;
	final Widget child;

	StateFulWrapper({required Key key, required this.onInit, required this.child}) : super(key: key);

	_StateFulWrapper createState() => _StateFulWrapper();
}

class _StateFulWrapper extends State<StateFulWrapper> {
	@override
	void initState() {
		widget.onInit();
		super.initState();
	}

	Widget build(BuildContext context) {
		return widget.child;
	}
}
