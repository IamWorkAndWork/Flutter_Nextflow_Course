import 'package:flutter/material.dart';
import 'package:nextflow_personal_post/provider/post_provider.dart';
import 'package:provider/provider.dart';

import 'new_post_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    var provider = Provider.of<PostProvider>(context, listen: false);
    provider.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TimeLine"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (BuildContext context) {
                          return NewPostPage();
                        }));
              }),
        ],
      ),
      body: Consumer<PostProvider>(
        builder: (BuildContext context, PostProvider provider, Widget child) {
          return ListView.builder(
            itemCount: provider.posts.length,
            itemBuilder: (BuildContext context, int index) {
              var item = provider.posts[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${item.timeAgoMessage}",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${item.message}",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
