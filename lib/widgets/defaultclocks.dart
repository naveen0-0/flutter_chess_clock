import 'package:chessclock/pages/details.dart';
import 'package:flutter/material.dart';
import '../models/Clock.dart';

class DefaultClocks extends StatefulWidget {
  const DefaultClocks({Key? key}) : super(key: key);
  @override
  _DefaultClocksState createState() => _DefaultClocksState();
}

class _DefaultClocksState extends State<DefaultClocks> {
  late List<Clock> _clocks;
  @override
  void initState() {
    _clocks = Clock.clocks;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _clocks.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Details(time: _clocks[index].time,increment: _clocks[index].increment,)));
            },
            child: Card(
              color: Colors.grey.shade800,
              child: Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 5),
                                child: Text(_clocks[index].name,
                                    style: TextStyle(fontSize: 20,color: Colors.white)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 0),
                            child: Row(
                              children: [
                                Row(
                                  children: [Icon(Icons.alarm,size: 16,color: Colors.white70,), Text(calculateTime(_clocks[index].time),style: TextStyle(color: Colors.white70),)],
                                ),
                                Row(
                                  children: [Icon(Icons.arrow_upward,size: 16,color: Colors.white70,), Text(calculateIncreament(_clocks[index].increment),style: TextStyle(color: Colors.white70))],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 0),
                            child: Row(
                              children: [
                                Row(
                                  children: [Icon(Icons.alarm,size: 16,color: Colors.white54,), Text(calculateTime(_clocks[index].time),style: TextStyle(color: Colors.white54))],
                                ),
                                Row(
                                  children: [Icon(Icons.arrow_upward,size: 16,color: Colors.white54,), Text(calculateIncreament(_clocks[index].increment),style: TextStyle(color: Colors.white54))],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.play_arrow,color: Colors.grey,),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String calculateTime(Duration time) {
    var hours = time.inHours;
    var minutes = time.inMinutes;
    var seconds = time.inSeconds;
    var jiM = minutes.remainder(60);
    var jiS = seconds.remainder(60);

    if(hours == 0 && minutes == 0 && seconds == 0){
      return "00:00:00";
    }else if(hours == 0 && minutes != 0 && seconds != 0){
      return '${jiM}:${jiS}';
    }else if(hours == 0 && minutes == 0 && seconds != 0){
      return '${jiM}:${jiS}';
    }else{
      return '${hours}:${jiM}:${jiS}';
    }
  }

  String calculateIncreament(Duration time) {
    var hours = time.inHours;
    var minutes = time.inMinutes;
    var seconds = time.inSeconds;
    var jiS = seconds.remainder(60);

    if(hours == 0 && minutes == 0 && seconds == 0){
      return "0s";
    }else{
      return '${jiS}s';
    }
  }
}
