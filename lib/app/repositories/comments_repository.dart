import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tableproject/app/models/comment_model.dart';

class CommentsRepository {
  static const String url = 'http://jsonplaceholder.typicode.com/comments';

  Future<List<CommentModel>> fetchComments() async {
    final http.Response response = await http.get(Uri.parse(url));

    List<CommentModel> comments;

    if (isStatusCode200(response)) {
      final List<dynamic> responseJson = jsonDecode(response.body) as List<dynamic>;
      comments =
          responseJson.map((dynamic e) => CommentModel.fromJson(e)).toList();
      print('Successful comment fetch');
      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }

  bool isStatusCode200(http.Response response) => response.statusCode == 200;
}
