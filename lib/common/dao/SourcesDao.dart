import 'package:news_app/api/Api.dart';
import 'package:news_app/api/ApiMap.dart';
import 'package:news_app/common/dao/DaoResult.dart';
import 'package:news_app/common/model/Sources.dart';
import 'package:news_app/common/model/ErrorEntity.dart';

class SourcesDao {

	static getSources() async {
		var res = await HttpManager.netFetch(ApiMap.getSources(), null, null, null);
		if (res != null) {
			if (res.data["status"] == 'ok') {
				Sources json = Sources.fromJson(res.data);
				return new DataResult(true, json);
			} else {
				ErrorEntity json = ErrorEntity.fromJson(res.data);
				return new DataResult(false, json);
			}
		}
	}
}
