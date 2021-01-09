import 'package:flutter/material.dart';

void main() {
  var app = MyApp();

  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: CounterArea(),
    );
  }
}

class CounterArea extends StatefulWidget {
  CounterArea({Key key}) : super(key: key);

  @override
  _CounterAreaState createState() => _CounterAreaState();
}

class _CounterAreaState extends State<CounterArea> {
  int _counter = 0;

  void onCounterButtonPressed() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter CounterArea"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("กดปุ่มถ้าต้องการเพิ่มตัวนับ"),
          Text(
            '$_counter',
            style: TextStyle(fontSize: 60, color: Colors.blue),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: onCounterButtonPressed,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
