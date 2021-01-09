import 'package:flutter/foundation.dart';
import 'package:nextflow_personal_post/database/post_db.dart';
import 'package:nextflow_personal_post/database/post_db_sqflite.dart';
import 'package:nextflow_personal_post/database/post_db_sqlite.dart';
import 'package:nextflow_personal_post/models/post_model.dart';

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  PostDbSQFLite _postDb;

  List<Post> get posts => _posts;

  PostProvider() {
    _postDb = PostDbSQFLite(databaseName: "app.db");
  }

  addNewPost(String postMessage) async {
    var post = Post(createdDate: DateTime.now(), message: postMessage);

    var dataId = await _postDb.save(post);

    print("save success dataId = $dataId");

    var postsFromDb = await _postDb.loadAllPosts();

    _posts = postsFromDb;

    notifyListeners();
  }

  initData() async {
    _posts = await _postDb.loadAllPosts();
    notifyListeners();
  }

  clearAllPost() async {
    await _postDb.clearPostData();

    _posts = [];
    notifyListeners();
  }
}
