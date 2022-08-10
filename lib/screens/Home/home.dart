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
  //list to store the data from api
  List<dynamic> _users = [];
  //for logout
  final AuthService _auth = AuthService();
  @override
  void initState() {
    super.initState();
    //calling the function on rendering this component
    _loading = false;
    loadUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      //use of listview functions to display the array of data on screens into different cards
      body: _users.isNotEmpty
          ? ListView.builder(
              itemCount: _users.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: Container(
                    height: 100,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(1),
                            child: Expanded(
                              child: Image.asset(
                                "img/weather.jpeg",
                                height: 100,
                                width: 100,
                              ),
                              flex: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: ListTile(
                                    title: Text(_users[index]['name']),
                                    subtitle: Text(_users[index]['date']),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          flex: 8,
                        ),
                      ],
                    ),
                  ),
                  elevation: 8,
                  margin: EdgeInsets.all(10),
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

//function to fetch data from api and storing into states
  loadUserList() async {
    setState(() {
      _loading = true;
    });
    var res = await http
        .get(Uri.parse("https://date.nager.at/api/v3/PublicHolidays/2022/CA"));
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
