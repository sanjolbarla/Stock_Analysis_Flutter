import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'screens/login_page.dart';

void main() {
  runApp(StockChange());
}

class StockChange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Change',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LogIn(),
    );
  }
}
