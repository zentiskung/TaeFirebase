import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taefirebase/screens/my_service.dart';
import 'package:taefirebase/screens/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double size = 120.0;
  String emailString, passwordString;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    checkStatus(context);
  }

  void checkStatus(BuildContext context) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();

    if (firebaseUser != null) {
      moveToService(context);
    }
  }

  void moveToService(BuildContext context){
    var serviceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context)
          .pushAndRemoveUntil(serviceRoute, (Route<dynamic> route) => false);
  }

  Widget space() {
    return SizedBox(
      height: 16.0,
      width: 5.0,
    );
  }

  Widget showlogo() {
    return Container(
      width: size,
      height: size,
      alignment: Alignment(0, -1),
      child: Image.asset(
        'images/logo_data.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget showAppName() {
    return Container(
      alignment: Alignment(0, -1),
      child: Text(
        'Tae Firebase',
        style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent),
      ),
    );
  }

  Widget emailTextFromField() {
    return Container(
      width: 250.0,
      alignment: Alignment(0, -1),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Email :',
          hintText: 'you@email.com',
        ),
        onSaved: (String value) {
          emailString = value;
        },
      ),
    );
  }

  Widget passwordextFromField() {
    return Container(
      width: 250.0,
      alignment: Alignment(0, -1),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Password :',
          hintText: 'More 6 Charactor',
        ),
        onSaved: (String value) {
          passwordString = value;
        },
      ),
    );
  }

  Widget signUp(BuildContext context) {
    return Expanded(
      child: RaisedButton(
        color: Colors.blueAccent[700],
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          print('You Click SignUp');
          var registerRoute =
              MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(registerRoute);
        },
      ),
    );
  }

  Widget signIn(BuildContext context) {
    return Expanded(
      child: RaisedButton(
        color: Colors.blueAccent[100],
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          formKey.currentState.save();
          checkEmailAndPass(context);
        },
      ),
    );
  }

  void checkEmailAndPass(BuildContext context) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((objValue) {
          moveToService(context);
        }).catchError((objError){
          String error = objError.message;
          print('error ==> $error');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
              gradient: RadialGradient(
                  colors: [Colors.white, Colors.blueAccent[700]],
                  center: Alignment(0, 0),
                  radius: 2.0)),
          padding: EdgeInsets.only(top: 60.0, left: 50.0, right: 50.0),
          alignment: Alignment(0, -1),
          child: Column(
            children: <Widget>[
              showlogo(),
              space(),
              showAppName(),
              emailTextFromField(),
              passwordextFromField(),
              space(),
              Container(
                  alignment: Alignment(0, -1),
                  width: 250.0,
                  child: Row(
                    children: <Widget>[signIn(context), space(), signUp(context)],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
