import 'package:assignment_fluter/screens/Home/Album.dart';
import 'package:assignment_fluter/screens/Home/News.dart';
import 'package:flutter/material.dart';
import 'package:assignment_fluter/services/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = false;
  List<dynamic> _users = [];
  final AuthService _auth = AuthService();
  @override
  void initState() {
    super.initState();
    _loading = false;
    loadUserList();
  }

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
              label: Text("News")),
          FlatButton.icon(
              onPressed: () async {
                await _auth.signout();
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
              },
              icon: Icon(Icons.person),
              label: Text("Log Out")),
        ],
      ),
      body: _users.isNotEmpty
          ? ListView.builder(
              itemCount: _users.length,
              itemBuilder: ((context, index) {
                return Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black, //<-- SEE HERE
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 20.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: [
                          Text(
                            _users[index]['name'],
                            style: TextStyle(fontSize: 20),
                          ),
                          // Text("Province : " +
                          //     (_users[index]['state-province'] == null
                          //         ? "Null"
                          //         : _users[index]['state-province'])),
                          // Image.network(
                          //   _users[index]['urlToImage'],
                          //   height: 400,
                          //   width: 400,
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            )
          : Center(
              child: _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      child: const Text("fetch users"),
                      onPressed: loadUserList,
                    ),
            ),
    );
  }

  loadUserList() async {
    setState(() {
      _loading = true;
    });
    var res = await http.get(
        Uri.parse("http://universities.hipolabs.com/search?country=canada"));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);

      if (jsonData.isNotEmpty) {
        print(jsonData[0]['name']);
        setState(() {
          _users = jsonData;
          _loading = false;
        });
      }
    }
  }
}


//news api
//https://newsapi.org/v2/top-headlines?q=${country}&apiKey=0ac95a24119645c29d0ec5478e888e7c


//college api
//http://universities.hipolabs.com/search?country=canada