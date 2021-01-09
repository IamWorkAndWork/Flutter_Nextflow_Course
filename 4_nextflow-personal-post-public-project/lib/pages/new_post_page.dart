import 'package:flutter/material.dart';
import 'package:nextflow_personal_post/models/post_model.dart';
import 'package:nextflow_personal_post/provider/post_provider.dart';
import 'package:provider/provider.dart';

class NewPostPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final postMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สร้างโพสใหม่"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                autofocus: true,
                controller: postMessageController,
                maxLines: 1,
                validator: (String text) {
                  if (text.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  if (text.length < 5) {
                    return "ความยาวต้องมากกว่า 5 ตัวอักษร";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Name",
                    border: InputBorder.none,
                    hintText: "คุณกำลังทำอะไรอยู่"),
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text("โพส"),
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      var message = postMessageController.text;
                      print('message = $message');
                      var postProvider =
                          Provider.of<PostProvider>(context, listen: false);
                      postProvider.addNewPost(message);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
