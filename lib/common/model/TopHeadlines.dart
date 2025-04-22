import 'package:json_annotation/json_annotation.dart';
import 'package:news_app/common/model/Article.dart';

part 'TopHeadlines.g.dart';

@JsonSerializable()
class TopHeadlines {
	String? status;
	int? totalResults;
	List<Article?>? articles;

	TopHeadlines({this.status, this.totalResults, this.articles});

	factory TopHeadlines.fromJson(Map<String, dynamic> json) => _$TopHeadlinesFromJson(json);

	Map<String, dynamic> toJson() => _$TopHeadlinesToJson(this);

	TopHeadlines.empty();
}
