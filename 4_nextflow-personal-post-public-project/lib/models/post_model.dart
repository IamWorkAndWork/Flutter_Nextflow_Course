import 'package:sembast/sembast.dart';
import 'package:timeago/timeago.dart' as timeago;

class Post {
  String message;
  DateTime createdDate;

  Post({this.message, this.createdDate});

  String get timeAgoMessage {
    var now = DateTime.now();
    var duration = now.difference(createdDate);
    var ago = now.subtract(duration);
    var message = timeago.format(ago, locale: 'th_short');
    return message;
  }

  static Map<String, dynamic> toJson(Post post) {
    var json = {
      'message': post.message,
      'createdTime': post.createdDate.toIso8601String()
    };
    return json;
  }

  static fromRecord(RecordSnapshot record) {
    var _createdDate = DateTime.parse(record["createdTime"]);
    var post = Post(message: record["message"], createdDate: _createdDate);
    return post;
  }
}
