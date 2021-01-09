import 'package:nextflow_personal_post/models/post_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class PostDbSQFLite {
  String databaseName;
  PostDbSQFLite({this.databaseName});

  Future<sqflite.Database> openDataBase() async {
    var appDucumentDirectory = await getApplicationDocumentsDirectory();
    var databaseLocaionInApp =
        join(appDucumentDirectory.path, this.databaseName);

    var database = await sqflite.openDatabase(databaseLocaionInApp, version: 1,
        onCreate: (db, version) async {
      var sql = "create table if not exists Posts( " +
          "id integer primary key autoincrement, " +
          "message Text, " +
          "createdDate datetime)";
      await db.execute(sql);
    });
    return database;
  }

  Future<int> save(Post post) async {
    var database = await this.openDataBase();
    var sql = "insert into Posts values(?, ?, ?)";
    var result = await database.rawInsert(
        sql, [null, post.message, post.createdDate.toIso8601String()]);
    return result;
  }

  Future<List<Post>> loadAllPosts() async {
    var postsList = List<Post>();

    var sql = "select * from Posts order by id desc";
    var database = await openDataBase();
    var results = await database.rawQuery(sql);
    for (var result in results) {
      var message = result["message"];
      var createdDate = DateTime.tryParse(result["createdDate"]);
      var post = Post(message: message, createdDate: createdDate);
      postsList.add(post);
    }

    return postsList;
  }

  Future<void> clearPostData() async {
    var sql = "delete from Posts";
    var database = await openDataBase();
    var rows = await database.rawDelete(sql);
  }
}
