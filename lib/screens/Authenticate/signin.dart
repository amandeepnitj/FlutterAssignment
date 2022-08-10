import 'package:assignment_fluter/screens/Authenticate/register.dart';
import 'package:assignment_fluter/screens/Home/home.dart';
import 'package:assignment_fluter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //use of text editing controller to store the data from input -> text fields
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  //use of error variable.... if there is any error in login , the error data will be displayed ... see the code
  String error = "";
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        elevation: 0.0,
        title: Text("Sign In"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Enter Email"),
            controller: emailcontroller,
          ),
          TextField(
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: "Enter Password"),
            controller: passwordcontroller,
            obscureText: true,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            error,
            style: TextStyle(color: Colors.red, fontSize: 14.0),
          ),
          RaisedButton(
            child: Text("Sign In "),
            onPressed: () async {
              dynamic result = await _auth.SignInEmailAndPassword(
                  emailcontroller, passwordcontroller);
              if (result == false) {
                print("error in SignIn ");
                //storing string in error after getting any error in login
                setState(
                    () => error = "error in Sign In, please try again later");
              } else {
                print("sign in  done");
                print(result);
                //use of navigator  to navigate b/w screens
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text("If you don't have an account?"),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
              child: Text("Register"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              }),
        ]),
      ),
    );
  }
}
