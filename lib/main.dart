import 'package:flutter/material.dart';
import 'homepage.dart';

const Color myColor = Colors.deepOrange;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Code Kaksha",
      theme: ThemeData(
        primarySwatch: myColor,
        fontFamily: "Quicksand",
      ),
      home: HomePage(),
    );
  }
}
