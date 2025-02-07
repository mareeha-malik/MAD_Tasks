// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.teal,
//         body: Container(
//           color: Colors.white,
//           child: Text('Hello'),
//         ),
//
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan,
        // body: widget(
        body: SafeArea(
          child: Container(
            height: 100.0,
            width: 100.0,
            // margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0 ),
            // margin: EdgeInsets.fromLTRB(30.0, 20.0, 40.0, 10.0),
            margin: EdgeInsets.only(left: 10.0, top:10.0, right:10.0),
            padding: EdgeInsets.only(left:30.0, right:10.0,top:20.0),
            color: Colors.white,
            child: Text('Hello'),
          ),
        ),
      ),
    );
  }
}