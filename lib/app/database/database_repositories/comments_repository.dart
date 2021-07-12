import 'package:sqflite/sqflite.dart';
import 'package:tableproject/app/database/database.dart';
import 'package:tableproject/app/models/comment_model.dart';
import 'package:tableproject/app/utils/constants.dart';

class DBCommentsRepo {
  DBCommentsRepo() {
    databaseHelper = DatabaseHelper();
  }

  DatabaseHelper? databaseHelper;

  Future<int> insertCommentsModel(CommentModel model) async {
    int result = 0;
    final Database db = await databaseHelper!.database;
    final int? count = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM ${Constants.USER_COMMENTS_TABLE} WHERE id = ?',
        <int?>[model.id]));
    if (count == 0) {
      result = await db.insert(Constants.USER_COMMENTS_TABLE, model.dbToJson());
    } else {
      result = await db.update(Constants.USER_COMMENTS_TABLE, model.dbToJson(),
          where: 'id = ?', whereArgs: <int?>[model.id]);
    }

    return result;
  }

  Future<List<CommentModel>> fetchComments() async {
    final List<CommentModel> listComments = <CommentModel>[];
    final Database db = await databaseHelper!.database;
    final List<Map<String, dynamic>> result =
        await db.query(Constants.USER_COMMENTS_TABLE);

    result.map((Map<String, dynamic> e) {
        listComments.add(CommentModel.fromJson(e));
    }).toList();

    return listComments;
  }

  Future<int> deleteComments(int id) async {
    int result = 0;
    final Database db = await databaseHelper!.database;
    result = await db.delete(Constants.USER_COMMENTS_TABLE,
        where: 'id = ?', whereArgs: <int>[id]);

    return result;
  }
}
