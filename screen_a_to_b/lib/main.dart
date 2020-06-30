import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    title: 'screens',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _nameFieldController = new TextEditingController();
  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context).push(
      new MaterialPageRoute<Map>(
          builder: (BuildContext context) {
            return new NextScreen(name: _nameFieldController.text,);
          })
    );
    if (results != null && results.containsKey("info")) {
      print(results['info'].toString());
      _nameFieldController.text = results['info'].toString();
    } else {
      print ('Nothing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Screen'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new TextField(
              controller: _nameFieldController,
              decoration: new InputDecoration(labelText: 'Enter Your Name'),
            ),
          ),
          new ListTile(
            title: new RaisedButton(
                child: new Text('Send to new screen'),
                onPressed: () {_goToNextScreen(context);}
                ),
          )
        ],
      ),
    );
  }
}

class NextScreen extends StatefulWidget {
  final String name;

  const NextScreen({Key key, this.name}) : super(key: key);

  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  final _backTextFieldController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.greenAccent,
        title: new Text('Second Screen'),
      ),
//      body: new ListTile(
//        title: new Text('${widget.name}'),
//      ),
    body: new Container(
      child: new Column(
        children: <Widget>[
          new ListTile(
            title: new Text('${widget.name}'),
          ),
          new ListTile(
            title: new TextField(
              controller: _backTextFieldController,
            ),
          ),
          new ListTile(
            title: new FlatButton(
              color: Colors.black38,
                splashColor: Colors.greenAccent,
                onPressed: () {
                  Navigator.pop(context, {
                    'info': _backTextFieldController.text
                  });
                },
                child: new Text('Send data back')),
          )
        ],
      ),
    ),
    );
  }
}
