import 'package:flutter/material.dart';
import 'package:nextflow_personal_post/provider/post_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: RaisedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("แน่ใจหรือ?"),
                    content: Text("นี่จะเป็นการลบข้อมูลทั้งหมดใน Timeline"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("ยกเลิก")),
                      FlatButton(
                          onPressed: () {
                            Provider.of<PostProvider>(context, listen: false)
                                .clearAllPost();
                            Navigator.pop(context);
                          },
                          child: Text("ยืนยัน")),
                    ],
                  );
                });
          },
          child: Text("ลบข้อมูลทั้งหมด"),
          color: Colors.blue,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
