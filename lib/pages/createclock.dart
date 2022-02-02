import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


class CreateClock extends StatefulWidget {
  const CreateClock({ Key? key }) : super(key: key);
  @override
  State<CreateClock> createState() => _CreateClockState();
}

class _CreateClockState extends State<CreateClock> {
  int _hours=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: Text("Create Clock"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            NumberPicker(minValue: 0, maxValue: 10, value: _hours, onChanged:(val){
              setState(() {
                _hours = val;
              });
            }),
            Text("Create Clock"),
          ],
        ),
      ),
    );
  }
}
