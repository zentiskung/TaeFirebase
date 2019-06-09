import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    readDatabase(context);
  }

  void readDatabase(BuildContext context) async {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    var objData = await firebaseDatabase.reference().child('User');
    StreamBuilder(
      stream: objData.onValue,
      builder: (BuildContext context, snap) {
        DataSnapshot dataSnapshot = snap.data;
        print(dataSnapshot.value);
      },
    );
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        signOutProcess();
      },
    );
  }

  void signOutProcess() {
    firebaseAuth.signOut().then((objValue) {
      exit(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
        actions: <Widget>[signOutButton()],
      ),
      body: Text('body'),
    );
  }
}
