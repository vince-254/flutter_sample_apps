import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        ClipPath(
          child: Container(
            color: Colors.black.withOpacity(0.8),
          ),
          clipper: getClipper(),
        ),
        Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                        image: AssetImage("assets/avatar.png"),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [BoxShadow(
                        blurRadius: 7.0,
                        color: Colors.black,
                        spreadRadius: 2.0
                      )
                      ]
                  ),
                ),
                SizedBox(height: 90.0,),
                Text(
                    "Vince",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat"
                  ),
                ),
                SizedBox(height: 15.0,),
                Text(
                  "View details",
                  style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Montserrat"
                  ),
                ),
                SizedBox(height: 25.0,),
                Container(
                  height: 30.0,
                  width: 95.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.green,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                            "Edit Name",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat'
                          ),
                        ),
                      ),

                    ),
                  ),
                ),
          SizedBox(height: 25.0,),
          Container(
            height: 30.0,
            width: 150,
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              shadowColor: Colors.greenAccent,
              color: Colors.amber,
              elevation: 7.0,
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text(
                    "Change Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat'
                    ),
                  ),
                ),

              ),
            ),
          ),
                SizedBox(height: 25.0,),
                Container(
                  height: 30.0,
                  width: 95.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.greenAccent,
                    color: Colors.red,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          "Log out",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat'
                          ),
                        ),
                      ),

                    ),
                  ),
                )

              ],
            ))
      ],
    ));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 150, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
