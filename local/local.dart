import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

String command;

class LocalCommand extends StatefulWidget {
  @override
  _LocalCommandState createState() => _LocalCommandState();
}

class _LocalCommandState extends State<_LocalCommandState> {
  var webdata;
  web(command) async {
    var url = "http://192.168.1.6/cgi-bin/app.py?x=${command}";
    var r = await http.get(url);
    setState(() {
      webdata = r.body;
    });
    print(webdata);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.laptop_chromebook),
        title: Text('TERMINAL'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.black,
            child: Column(
              children: [
                Container(
                  child: Card(
                    color: Colors.black,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: Colors.blue)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      onChanged: (val) {
                        command = val;
                      },
                      autocorrect: false,
                      cursorColor: Colors.blue,
                      style: TextStyle(height: 1, color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter Linux Command ',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 6, color: Colors.blue)),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue)),
                      color: Colors.black,
                      onPressed: () {
                        web(command);
                      },
                      child: Icon(
                        Icons.settings_power,
                        color: Colors.white,
                      )),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    color: Colors.black,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: Colors.blue)),
                    child: Text(
                      webdata ??
                          "                       Welcome To Terminal...",
                      style: TextStyle(height: 3, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
