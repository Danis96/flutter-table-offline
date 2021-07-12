// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
    body: json['body'] as String? ?? '',
    id: json['id'] as int? ?? 0,
    email: json['email'] as String? ?? '',
    name: json['name'] as String? ?? '',
    postID: json['postId'] as int? ?? 0,
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'postId': instance.postID,
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'body': instance.body,
    };
