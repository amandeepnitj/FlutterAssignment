import 'package:assignment_fluter/screens/Home/Album.dart';
import 'package:assignment_fluter/screens/wrapper.dart';
import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  //starting of the app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //turn off debug banner
      debugShowCheckedModeBanner: false,
      //call wrapper component
      home: Wrapper(),
    );
  }
}
