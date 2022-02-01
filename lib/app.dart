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
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings))
        ],
        bottom: TabBar(
          tabs: [
            Tab(child: Text("PRESETS"),),
            Tab(child: Text("CUSTOM"),),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: TabBarView(
              children: [
                DefaultClocks(),
                Text("CUSTOM"),
              ],
            ),
      ),
    );
  }
}