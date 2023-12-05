

import 'package:json_annotation/json_annotation.dart';

part 'article_entity.g.dart';

@JsonSerializable()
class ArticleEntity {

  final int id ;
  final int authorId ;
  final String titels;
  final String content;
  final String articleImage;

  ArticleEntity(
      {
       required this.id,
       required this.authorId,
       required this.titels,
       required this.content,
        required this.articleImage});

  factory ArticleEntity.fromJson(Map<String, dynamic> json) =>
      _$ArticleEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleEntityToJson(this);
}


