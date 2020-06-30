import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  
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
  String _savedData = "";
  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      if (preferences.getString('data') != null && preferences.getString('data').isNotEmpty) {
      _savedData = preferences.getString("data");
    } else {
      _savedData = "Empty";
    }

    });
  }

  _saveMessage(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('data', message); //key : value ==> "password" : "123"
  }

  @override
  Widget build(BuildContext context) {
    var _enterDataField = new TextEditingController();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shared Preferences'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
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
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  //Save to file
                  _saveMessage(_enterDataField.text);
                },
              ),
            ),
          ),

          new Center(
              child: new Column(
                children: <Widget>[
                  new Padding(padding: new EdgeInsets.all(14.5)),
                  new Text(_savedData)
                ],
              )
          )
        ],
      ),
    );
  }
}

