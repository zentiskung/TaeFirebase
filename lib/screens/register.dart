import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:taefirebase/screens/my_service.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;

  Widget uploadButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'Name = $nameString, Email = $emailString, Password = $passwordString');
          uploadValueToFirebase();
        }
      },
    );
  }

  void uploadValueToFirebase() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((objValue) {
      print('Success Regiter');

      String uidString = objValue.uid.toString();
      print('uidString ==> $uidString');

      updateDatabase(uidString, context);
    }).catchError((error) {
      String errorString = error.message;
      print('Error ===> $errorString');
      showAlertDialog('Cannot Registerd', errorString);
    });
  }

  void updateDatabase(String uidString, BuildContext context) async {
    FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
    Map<String, String> map = Map();
    map['Email'] = emailString;
    map['Name'] = nameString;
    map['Uid'] = uidString;

    await firebaseDatabase
        .reference()
        .child('User')
        .child(uidString)
        .set(map)
        .then((objValue) {
      // Move to MyService

      var serviceRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context)
          .pushAndRemoveUntil(serviceRoute, (Route<dynamic> route) => false);
    });
  }

  void showAlertDialog(String titleString, String messageString) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleString),
          content: Text(messageString),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget nameTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Name :',
            hintText: 'Request',
          ),
          validator: (String value) {
            if (value.length == 0) {
              return 'Please Fill Name In Blank';
            }
          },
          onSaved: (String value) => nameString = value,
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Email :',
            hintText: 'you@abc.com',
          ),
          validator: (String value) {
            if (!((value.contains('@')) && (value.contains('.')))) {
              return 'Please Type Email Format';
            }
          },
          onSaved: (String value) {
            emailString = value;
          },
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password :',
            hintText: 'More 6 Charactor',
          ),
          validator: (String value) {
            if (value.length <= 5) {
              return 'More 6 Charactor';
            }
          },
          onSaved: (String value) => passwordString = value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[uploadButton(context)],
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(top: 80.0),
          alignment: Alignment(0, -1),
          child: Column(
            children: <Widget>[
              nameTextFormField(),
              emailTextFormField(),
              passwordTextFormField()
            ],
          ),
        ),
      ),
    );
  }
}
