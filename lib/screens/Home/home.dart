import 'package:assignment_fluter/screens/Home/Album.dart';
import 'package:assignment_fluter/screens/Home/News.dart';
import 'package:flutter/material.dart';
import 'package:assignment_fluter/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        elevation: 0.0,
        title: Text("Home"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.signout();
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              },
              icon: Icon(Icons.person),
              label: Text("Log Out")),
          FlatButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Album_1()),
                );
              },
              icon: Icon(Icons.ac_unit),
              label: Text("Weather")),
          FlatButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => News()),
                );
              },
              icon: Icon(Icons.newspaper),
              label: Text("News"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            child: Text("Sign Out"),
            onPressed: () async {
              await _auth.signout();
              Navigator.pop(context);
            },
          ),
        ]),
      ),
    );
  }
}


//news api
//https://newsapi.org/v2/top-headlines?q=${country}&apiKey=0ac95a24119645c29d0ec5478e888e7c