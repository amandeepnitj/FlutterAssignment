// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// this class handles all the serrvices of firebase
class AuthService {
  //declare and initializing firebase auth variable
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in anon
  // function for sign in anonymously
  Future signInAnon() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  // function for sign in email and password
  Future SignInEmailAndPassword(emailAddress, password) async {
    var credential;
    var success = true;
    try {
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress.text.trim(), password: password.text.trim());
      success = true;
      return success;
    } on FirebaseAuthException catch (e) {
      success = false;
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return success;
    }
  }

  // function for register with email and password

  Future Register(emailAddress, password) async {
    var success = true;
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress.text.trim(),
        password: password.text.trim(),
      );
      success = true;
      return success;
    } on FirebaseAuthException catch (e) {
      success = false;
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // function for signout
  Future signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
