import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nextflow_covid_today/models/CovidTodayResponse.dart';
import 'stat_box.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nextflow COVID-19 Today',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Nextflow COVID-19 Today'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // CovidTodayResponse _dataFromWebAPI;

  @override
  void initState() {
    super.initState();

    print("init state");

    getData();
  }

  Future<CovidTodayResponse> getData() async {
    print('get data');
    var response = await http.get('https://covid19.th-stat.com/api/open/today');

    print("response = ${response.body}");

    // setState(() {
    var _dataFromWebAPI = covidTodayResponseFromJson(response.body);
    // });
    return _dataFromWebAPI;
  }

  @override
  Widget build(BuildContext context) {
    print("build");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getData(),
        builder:
            (BuildContext context, AsyncSnapshot<CovidTodayResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var _dataFromWebAPI = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  StatBox(
                    title: "ผู้ติดเชื้อสะสม",
                    total: _dataFromWebAPI?.confirmed ?? 0,
                    backgroundColor: Color(0xff0F6E33),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StatBox(
                    title: "หายแล้ว",
                    total: _dataFromWebAPI?.recovered ?? 0,
                    backgroundColor: Colors.cyanAccent,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StatBox(
                    title: "รักษาอยู่ในโรงพยาบาล",
                    total: _dataFromWebAPI?.hospitalized ?? 0,
                    backgroundColor: Colors.deepPurple,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StatBox(
                    title: "ผู้เสียชีวิต",
                    total: _dataFromWebAPI?.deaths ?? 0,
                    backgroundColor: Colors.lightBlue,
                  )
                ],
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          }
        },
      ),
      // body: Column(
      //   children: [
      //     indicator ?? Container(),
      //     Expanded(
      //       child: ListView(
      //         children: <Widget>[
      //           ListTile(
      //             title: Text("ผู้ติดเชื้อสะสม"),
      //             subtitle: Text("${_dataFromWebAPI?.confirmed ?? '0'}"),
      //           ),
      //           ListTile(
      //             title: Text("หายแล้ว"),
      //             subtitle: Text("${_dataFromWebAPI?.recovered ?? '0'}"),
      //           ),
      //           ListTile(
      //             title: Text("รักษาอยู่ในโรงพยาบาล"),
      //             subtitle: Text("${_dataFromWebAPI?.hospitalized ?? '0'}"),
      //           ),
      //           ListTile(
      //             title: Text("ผู้เสียชีวิต"),
      //             subtitle: Text("${_dataFromWebAPI?.deaths ?? '0'}"),
      //           ),
      //         ],
      //       ),
      //     )
      //   ],
      // )
    );
  }
}
