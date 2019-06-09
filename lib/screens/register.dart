import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {},
    );
  }

  Widget nameTextFormField() {
    return Container(
      alignment: Alignment(0, -1),
      child: Container(
        width: 250.0,
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Name :', hintText: 'Request'),
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
          decoration:
              InputDecoration(labelText: 'Email :', hintText: 'you@abc.com'),
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
              labelText: 'Password :', hintText: 'More 6 Charactor'),
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
        actions: <Widget>[uploadButton()],
      ),
      body: Container(
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
    );
  }
}
