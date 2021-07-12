import 'package:flutter/foundation.dart';
import 'package:tableproject/app/database/database_repositories/comments_repository.dart';
import 'package:tableproject/app/models/comment_model.dart';
import 'package:tableproject/app/repositories/comments_repository.dart';

class CommentProvider extends ChangeNotifier {
  CommentProvider() {
    _commentsRepository = CommentsRepository();
    _dbCommentsRepo = DBCommentsRepo();
  }

  DBCommentsRepo? _dbCommentsRepo;
  CommentsRepository? _commentsRepository;

  List<CommentModel>? _comments;

  List<CommentModel>? get comments => _comments;


  Future<void> getDBComments() async {
    try {
      _comments = await _dbCommentsRepo!.fetchComments();
      getComments();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String?> getComments() async {
    try {
      _comments = await _commentsRepository!.fetchComments();
      await insertCommentsIntoDB(_comments);
      notifyListeners();
      return null;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future<void> insertCommentsIntoDB(List<CommentModel>? comments) async {
    for (final CommentModel model in comments!) {
      try {
        await _dbCommentsRepo!.insertCommentsModel(model);
      } catch (e) {
        print(e.toString());
      }
    }
  }

}
