import 'package:flutter/material.dart';
import 'models/contact.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Contact> genContacts() {
    List<Contact> contacts = [];
    for (var i = 0; i < 20; i++) {
      var image = "assets/images/nextflow.png";
      // var image = "https://flutter.dev/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png";
      var contact = Contact("name john", "0123456789", image);
      contacts.add(contact);
    }
    return contacts;
  }

  @override
  Widget build(BuildContext context) {
    var contacts = genContacts();

    return Scaffold(
        appBar: AppBar(
          title: Text("Nextflow Contact"),
        ),
        body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            var contact = contacts[index];
            return ListTile(
              leading: Image.asset(contact.image),
              title: Text("item ${contact.name}"),
              subtitle: Text(contact.phoneNumber),
              onTap: () {
                launch('tel:${contact.phoneNumber}');
              },
            );
          },
        ));
  }
}
