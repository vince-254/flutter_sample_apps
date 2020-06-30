import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Map _data;
List _features; //features object list
void main() async {
  _data = await getJson();
  _features = _data['features'];

//  for (int i = 0; i < _data.length; i++) {
////   _data.forEach((k,v) => print('${k}: ${v}'));
//    print("place: ${_data['features'][0]['properties']['place']}");
//    print("time: ${_data['features'][0]['properties']['time']}");
//    print("mag: ${_data['features'][0]['properties']['mag']}");
//  }

  runApp(MaterialApp(
    title: 'Quake App',
    home: new Quakes(),
  ));
}

class Quakes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Quake App'),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: new Center(
        child: new ListView.builder(
            itemCount: _features.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (BuildContext context, int position) {
              //Rows for list view
              if (position.isOdd) {
                return new Divider();
              }
              final index =
                  position ~/ 2; //dividing position by 2 and retirning int
              var format = new DateFormat.yMMMMd("en_US").add_jm();
              var date = format.format(new DateTime.fromMicrosecondsSinceEpoch(_features[index]['properties']['time']*1000, isUtc: true));
              return new ListTile(
                title: new Text(
                  "Time: $date",
                  style: new TextStyle(
                      fontSize: 15.5,
                      color: Colors.orange,
                      fontWeight: FontWeight.w500),
                ),
                subtitle: new Text(
                  "${_features[index]['properties']['place']}",
                  style: new TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic),
                ),
                leading: new CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: new Text(
                    "${_features[index]['properties']['mag']}",
                    style: new TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                onTap: () {
                  _showAlertMessage(
                      context, "For more info visit: ${_features[index]['properties']['url']}");
                },
              );
            }),
      ),
    );
  }

  void _showAlertMessage(BuildContext context, String message) {
    var alert = new AlertDialog(
      title: new Text('Quakes'),
      content: new Text(message),
      actions: <Widget>[
        new FlatButton(onPressed: () {
          Navigator.pop(context);
        }, child: new Text('OK'))
      ],
    );
    showDialog(context: context, child: alert);
  }

}


Future<Map> getJson() async {
  String apiurl =
      'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson';
  http.Response response = await http.get(apiurl);
  return jsonDecode(response.body); //should return a map
}
