import 'package:dio/dio.dart';
import 'dart:collection';
import 'package:news_app/api/Code.dart';
import 'package:news_app/api/ResultData.dart';
import 'package:news_app/common/config/Config.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HttpManager {
	static const CONTENT_TYPE_JSON = "application/json";
	static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
	static Map<String, dynamic> optionParams = {
		"timeoutMs": 15000,
		"token": null,
	};

	static Future<ResultData> netFetch(
			String url,
			dynamic params,
			Map<String, String>? header,
			Options? option, {
				bool noTip = false,
			}) async {
		// Check network connectivity
		var connectivityResult = await Connectivity().checkConnectivity();
		if (connectivityResult == ConnectivityResult.none) {
			return ResultData(
				Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip),
				false,
				Code.NETWORK_ERROR,
			);
		}

		// Set request headers
		Map<String, String> headers = HashMap();
		if (header != null) {
			headers.addAll(header);
		}

		// Configure request options
		option ??= Options(method: "get");
		option.headers = headers;

		// Initialize Dio with timeout settings
		Dio dio = Dio(BaseOptions(
			connectTimeout: Duration(milliseconds: 15000),
			receiveTimeout: Duration(milliseconds: 15000),
			sendTimeout: Duration(milliseconds: 15000),
		));

		Response? response;
		try {
			response = await dio.request(url, data: params, options: option);
		} on DioException catch (e) {
			Response errorResponse;
			if (e.response != null) {
				errorResponse = e.response!;
			} else {
				errorResponse = Response(requestOptions: RequestOptions(path: url), statusCode: 666);
			}

			if (e.type == DioExceptionType.connectionTimeout) {
				errorResponse.statusCode = Code.NETWORK_TIMEOUT;
			}

			if (Config.DEBUG) {
				print('Request URL: $url, Error:' + e.toString());
			}
			return ResultData(
				Code.errorHandleFunction(errorResponse.statusCode, e.message ?? "", noTip),
				false,
				errorResponse.statusCode ?? Code.NETWORK_ERROR,
			);
		}

		if (Config.DEBUG) {
			print('-----------Start-----------');
			print('Request URL: $url');
			print('Request Parameters: $params');
			print('Response: ${response.toString()}');
			print('-----------End-----------');
		}

		try {
			if (response.statusCode == 200 || response.statusCode == 201) {
				return ResultData(
					response.data,
					true,
					Code.SUCCESS,
					header: response.headers,
				);
			}
		} catch (e) {
			return ResultData(
				response.data,
				false,
				response.statusCode ?? Code.NETWORK_ERROR,
				header: response.headers,
			);
		}

		return ResultData(
			Code.errorHandleFunction(response.statusCode ?? Code.NETWORK_ERROR, "", noTip),
			false,
			response.statusCode ?? Code.NETWORK_ERROR,
		);
	}
}