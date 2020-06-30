import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


void main() async{

  var data = await readData();
  if (data != null) {
    String message = await readData();
    print(message);
  }

  runApp(MaterialApp(
    title: 'IO',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var _enterDataField = new TextEditingController();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Read/Write'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(13.4),
            alignment: Alignment.center,
            child: new ListTile(
              title: new TextField(
                controller: _enterDataField,
                decoration: new InputDecoration(
                    labelText: 'Write Something'
                ),
              ),
              subtitle: new FlatButton(
                child: new Text('Save Data'),
                  color: Colors.greenAccent,
                  onPressed: () {
                //Save to file
                writeData(_enterDataField.text);
              },
                  ),
            ),
          ),
          
          new Center(
              child: new Column(
                children: <Widget>[
                  new Padding(padding: new EdgeInsets.all(14.5)),
                  new FutureBuilder(
                      future: readData(),
                      builder: (BuildContext context, AsyncSnapshot<String> data) {
                        if(data.hasData != null) {
                          return new Text(
                            data.data.toString(),
                            style: new TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20.0
                            ),

                          );
                        } else {
                          return new Text("Nothing saved yet");
                        }

                      })
                ],
              )
          )
        ],
      ),
    );
  }
}
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path; //home/directory/
  }
  Future<File> get _localFile async{
final path = await _localPath;
return new File('$path/dummydata.txt'); //home/directory/dummydata.txt
}

//Write and Read from our file
  Future<File> writeData(String message) async {
    final file = await _localFile;
    //write to file
    return file.writeAsString('$message');
  }

  //Read file
Future<String> readData() async {
    try {
      final file = await _localFile;
      //Read
      String data = await file.readAsString();
      return data;
    }
    catch (e) {
      return "Nothing saved yet" ;
    }
}

