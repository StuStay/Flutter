// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleEntity _$ArticleEntityFromJson(Map<String, dynamic> json) =>
    ArticleEntity(
      id: json['id'] as int,
      authorId: json['authorId'] as int,
      titels: json['titels'] as String,
      content: json['content'] as String,
      articleImage: json['articleImage'] as String,
    );

Map<String, dynamic> _$ArticleEntityToJson(ArticleEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'titels': instance.titels,
      'content': instance.content,
      'articleImage': instance.articleImage,
    };
