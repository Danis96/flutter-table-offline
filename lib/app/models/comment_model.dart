import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel {
  CommentModel({this.body, this.id, this.email, this.name, this.postID});

  factory CommentModel.fromJson(dynamic json) =>
      _$CommentModelFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  static CommentModel dbFromJson(dynamic json) {
    return CommentModel(
      id: json['id'] as int,
      postID: json['postId'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> dbToJson() {
    final Map<String, dynamic> map = <String, dynamic>{
      'id': id,
      'postId': postID,
      'name': name,
      'email': email,
      'body': body
    };

    return map;
  }

  @JsonKey(name: 'postId', defaultValue: 0)
  int? postID;
  @JsonKey(name: 'id', defaultValue: 0)
  int? id;
  @JsonKey(name: 'name', defaultValue: '')
  String? name;
  @JsonKey(name: 'email', defaultValue: '')
  String? email;
  @JsonKey(name: 'body', defaultValue: '')
  String? body;


  String get commentName => name!;
  String get commentEmail => email!;
  String get commentBody => body!;
  String get commentID => id!.toString();


}
