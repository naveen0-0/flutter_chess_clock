import 'package:chessclock/widgets/defaultclocks.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text("Chess Clock"),
      ),
      body: DefaultClocks(),
    );
  }
}