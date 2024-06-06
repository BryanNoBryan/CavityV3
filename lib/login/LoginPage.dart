import 'dart:developer';

import 'package:cavity3/widget/InputHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController errorMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Center(child: Image.asset('assets/images/cavity.jpg')),
          Center(
            child: Text(
              'Cavity',
              style: TextStyle(fontSize: 40),
            ),
          ),
          Center(child: InputHelper(name: 'Email', controller: email)),
          Center(child: InputHelper(name: 'Password', controller: password)),
          Center(
            child: Text(
              errorMessage.text,
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          ),
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: logIn,
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 32),
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: signUp,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 32),
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: 300,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: signInWithGoogle,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/google.jpg',
                        scale: 10,
                      ),
                      Text(
                        ' Google Login ',
                        style: TextStyle(fontSize: 32),
                      ),
                    ],
                  )),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> logIn() async {
    UserCredential credential;
    try {
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessage.text = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage.text = 'Wrong password provided for that user.';
      } else {
        errorMessage.text = 'Bad Format / Unknown Error.';
      }
      setState(() {});
      return;
    }
    //success!
    log(credential.user!.email!);
    email.text = '';
    password.text = '';
    errorMessage.text = '';
    //navigation handled by navigation/MyNavigator.dart
  }

  Future<void> signUp() async {
    UserCredential credential;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessage.text = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage.text = 'The account already exists for that email.';
      }
      setState(() {});
      return;
    } catch (e) {
      errorMessage.text = 'Unknown Error.';
      setState(() {});
      return;
    }

    //success!
    log(credential.user!.email!);
    email.text = '';
    password.text = '';
    errorMessage.text = '';
    //navigation handled by navigation/MyNavigator.dart
  }

  //prev type UserCredential
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    log(credential.idToken ?? 'null');

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    email.text = '';
    password.text = '';
    errorMessage.text = '';
    //navigation handled by navigation/MyNavigator.dart
  }
}
