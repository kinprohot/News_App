import 'package:news_app/api/Api.dart';
import 'package:news_app/api/ApiMap.dart';
import 'package:news_app/common/dao/DaoResult.dart';
import 'package:news_app/common/model/TopHeadlines.dart';
import 'package:news_app/common/model/ErrorEntity.dart';

class NewsDao {

	static getAllHeadLines(String params) async {
		var res = await HttpManager.netFetch(ApiMap.getAllHeadLines(params), params, null, null);
		if (res != null) {
			if (res.data["status"] == 'ok') {
				TopHeadlines json = TopHeadlines.fromJson(res.data);
				return new DataResult(true, json);
			} else {
				ErrorEntity json = ErrorEntity.fromJson(res.data);
				return new DataResult(false, json);
			}
		}
	}
}
