import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(
    MaterialApp(
    title: "Chess Clock",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.red
    ),
    home: DefaultTabController(
      child: MyApp(),
      length: 2,
    ),
  ));
}