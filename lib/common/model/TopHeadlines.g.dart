// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TopHeadlines.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopHeadlines _$TopHeadlinesFromJson(Map<String, dynamic> json) => TopHeadlines(
  status: json['status'] as String?,
  totalResults: (json['totalResults'] as num?)?.toInt(),
  articles:
      (json['articles'] as List<dynamic>?)
          ?.map(
            (e) =>
                e == null ? null : Article.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$TopHeadlinesToJson(TopHeadlines instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };
