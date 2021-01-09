import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  String _scanResult = "...";
  bool _isYoutube = false;
  bool _isLine = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ผลการแสกน",
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(_scanResult != -1 ? "..." : _scanResult),
                  Spacer(),
                  _isYoutube
                      ? SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.red,
                            onPressed: () async {
                              _scanResult =
                                  "https://www.youtube.com/watch?v=5VbAwhBBHsg";
                              if (await canLaunch(_scanResult)) {
                                if (Platform.isIOS) {
                                  await launch(_scanResult,
                                      forceSafariVC: false);
                                } else {
                                  await launch(_scanResult);
                                }
                              }
                            },
                            child: Text("เปิดแอป Youtube",
                                style: TextStyle(color: Colors.white)),
                          ))
                      : Container(),
                  _isLine
                      ? SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                              onPressed: () async {
                                if (Platform.isIOS) {
                                  await launch(_scanResult,
                                      forceSafariVC: false);
                                } else {
                                  await launch(_scanResult);
                                }
                              },
                              child: Text(
                                "เปิดแอพ Line",
                                style: TextStyle(color: Colors.green),
                              ),
                              color: Colors.green[600]),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: RaisedButton(
        onPressed: () {
          startScan();
        },
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SizedBox(
          width: 80,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.qr_code_rounded, color: Colors.white),
              Text(
                "แสกน",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  startScan() async {
    var lineColor = "#ffc2c2";
    var cancelButtonText = "ยกเลิกการแสกน";
    var isShowFlashIcon = true;
    var scanMode = ScanMode.DEFAULT;

    // var result = await FlutterBarcodeScanner.scanBarcode(
    //     lineColor, cancelButtonText, isShowFlashIcon, scanMode);

    // _isYoutube = false;
    // _isLine = false;

    // if (result != -1) {
    //   if (result.contains('youtube.com')) {
    //     _isYoutube = true;
    //   }
    //  if (result.contains("line.me")){
    _isLine = true;
    //  }

    //   setState(() {
    //     _scanResult = result;
    //   });
    // }
    setState(() {
      _isYoutube = true;
    });
  }
}
