import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class Details extends StatefulWidget {
  Duration time;
  Duration increment;

  Details({Key? key, required this.time, required this.increment}) : super(key: key);
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool gameStarted = false;
  bool whitesMove = false;
  bool blacksMove = false;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: whitesMove? () => null : (){
              setState(() {
                whitesMove=true;
                blacksMove=false;
              });
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: _screenWidth,
                    height: gameStarted? whitesMove?60:_screenHeight-60:_screenHeight/2,
                    color: Colors.grey.shade900,
                    child: Container(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Visibility(
                              visible: gameStarted,
                              child: FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    gameStarted = false;
                                  });
                                },
                                child: Icon(Icons.pause),
                                heroTag: null,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Transform.rotate( angle: math.pi, child: Text("Expandable 1",style: TextStyle(fontSize: 24,color: Colors.white54),),),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap:blacksMove? () => null: (){
                      setState(() {
                        whitesMove=false;
                        blacksMove=true;
                      });
                    },
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      width: _screenWidth,
                      height: gameStarted? blacksMove?60:_screenHeight-60:_screenHeight/2,
                      color: Colors.grey.shade700,
                      child: Container(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(child: Text("Expandable 2",style: TextStyle(fontSize: 24,color: Colors.grey.shade900),)),
                              SizedBox(
                                width: 10,
                              ),
                              Visibility(
                                visible: gameStarted,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      gameStarted = false;
                                    });
                                  },
                                  child: Icon(Icons.pause),
                                  heroTag: null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !gameStarted,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        gameStarted=true;
                        whitesMove=true;
                        blacksMove=false;
                      });
                    },
                    child: Icon(Icons.play_arrow),
                    heroTag: null,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    onPressed: () { Navigator.pop(context); },
                    child: Icon(Icons.close),
                    heroTag: null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
