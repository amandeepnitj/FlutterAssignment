import 'package:assignment_fluter/screens/Home/Album.dart';
import 'package:assignment_fluter/screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  bool _loading = false;
  //array of list to store the data from api
  List<dynamic> _users = [];
  @override
  void initState() {
    super.initState();
    //setting the states and calling the function , used to fetch data from api, in constructor
    setState(() {
      _loading = false;
      _users = [];
    });

    loadUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        elevation: 0.0,
        title: Text("News Canada"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              icon: Icon(Icons.home),
              label: Text(
                "Home",
                style: TextStyle(fontSize: 12),
              )),
          FlatButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Album_1()),
                );
              },
              icon: Icon(Icons.ac_unit),
              label: Text(
                "Weather",
                style: TextStyle(fontSize: 12),
              ))
        ],
      ),
      //use of listview to display the array of data into cards
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
                            _users[index]['title'] == null
                                ? "Null"
                                : _users[index]['title'],
                            style: TextStyle(fontSize: 20),
                          ),
                          Image.network(
                            _users[index]['urlToImage'] == null
                                ? "https://source.unsplash.com/300x200/?sikhs"
                                : _users[index]['urlToImage'],
                            height: 400,
                            width: 400,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ("Description :   " +
                                    _users[index]['description']),
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Published by " + _users[index]['author'] ==
                                      null
                                  ? "Null"
                                  : _users[index]['author']),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  height: 700,
                );
              }),
            )
          : CircularProgressIndicator(),
    );
  }

// function which is fetching data from api
  loadUserList() async {
    setState(() {
      _loading = true;
    });
    var res = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?q=us&pageSize=2&apiKey=0ac95a24119645c29d0ec5478e888e7c"));
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      if (jsonData['articles'].isNotEmpty) {
        setState(() {
          _users = jsonData['articles'];
          _loading = false;
        });
        print(_users[4]['title']);
      }
    }
  }
}
