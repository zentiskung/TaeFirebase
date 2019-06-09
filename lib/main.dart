import 'package:flutter/material.dart';
import 'package:taefirebase/screens/authen.dart';

// main() {
//   runApp(MyApp());
// }

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authen(),
    );
  }
}
