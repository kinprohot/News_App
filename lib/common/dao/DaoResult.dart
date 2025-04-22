import 'dart:async';

class DataResult {
	var data;
	bool status;
	Future? next;  // Add ? to make it nullable

	DataResult(this.status, this.data, {this.next});
}
