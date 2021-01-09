import 'dart:io';
import 'package:nextflow_personal_post/models/post_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class PostDb {
  String databaseName;

  PostDb(this.databaseName);

  Future<Database> openDatabase() async {
    Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
    String databaseLocationInApp =
        join(appDocumentDirectory.path, this.databaseName);

    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(databaseLocationInApp);
    return db;
  }

  Future<int> save(Post post) async {
    var database = await openDatabase();
    var postStore = intMapStoreFactory.store('posts');

    int dataId = await postStore.add(database, Post.toJson(post));

    database.close();

    return dataId;
  }

  Future<List<Post>> loadAllPosts() async {
    var database = await this.openDatabase();
    var postStore = intMapStoreFactory.store('posts');
    var snapshots = await postStore.find(database,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
    var postList = List<Post>();

    for (var record in snapshots) {
      var post = Post.fromRecord(record);
      postList.add(post);
    }

    return postList;
  }

  Future<void> clearPostData() async {
    var database = await this.openDatabase();
    var postStore = intMapStoreFactory.store('posts');
    await postStore.drop(database);
  }
}
