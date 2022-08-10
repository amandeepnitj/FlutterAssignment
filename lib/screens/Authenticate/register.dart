import 'package:assignment_fluter/screens/Authenticate/signin.dart';
import 'package:assignment_fluter/screens/Home/home.dart';
import 'package:assignment_fluter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //use of text editing controller to store the data from input -> text fields
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final AuthService _auth = AuthService();

  String email = "";
  String password = "";
  //use of error variable.... if there is any error in login , the error data will be displayed ... see the code

  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        elevation: 0.0,
        title: Text("Register"),
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
            //storing string in error after getting any error in login
            error,
            style: TextStyle(color: Colors.red, fontSize: 14.0),
          ),
          RaisedButton(
            child: Text("Register"),
            onPressed: () async {
              dynamic result =
                  await _auth.Register(emailcontroller, passwordcontroller);
              if (result == false) {
                print("error in Register");
                setState(
                    () => error = "error in SignUp, please try again later");
              } else {
                //use of navigator  to navigate b/w screens
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );

                print("register in  done");
                print(result);
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text("Already have an account?"),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
              child: Text("Sign In"),
              onPressed: () {
                Navigator.pop(context);
              }),
        ]),
      ),
    );
  }
}
