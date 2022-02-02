import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;


class Details extends StatefulWidget {
  final Duration time;
  final Duration increment;

  Details({Key? key, required this.time, required this.increment})
      : super(key: key);
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  bool gameStarted = false;
  bool gamePaused  = false;
  bool whitesMove = false;
  bool blacksMove = false;
  bool timeup = false;

  late Duration whiteDuration;
  late Duration whiteIncrement;
  Timer? whiteTimer;
  bool whitesTimeUp = false;

  late Duration blackDuration;
  late Duration blackIncrement;
  Timer? blackTimer;
  bool blacksTimeUp = false;

  @override
  void initState() {
    reset();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    whiteTimer?.cancel();
    blackTimer?.cancel();
    player.dispose();
    super.dispose();
  }

  void reset() {
    setState(() => {
          whiteDuration = widget.time,
          whiteIncrement = widget.increment,
          blackDuration = widget.time,
          blackIncrement = widget.increment,
          timeup=false,
          whitesTimeUp=false,
          blacksTimeUp=false
        });
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: blacksMove
                ? () async {
                    await player.setAsset('assets/audio/tap.mp3');
                    player.play();
                    setState(() {
                      whitesMove = true;
                      blacksMove = false;
                    });
                    stopBlackTimer();
                    startWhiteTimer();
                  }
                : () => null,
            child: Container(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    width: _screenWidth,
                    height: gameStarted
                        ? whitesMove
                            ? 80
                            : _screenHeight - 80
                        : _screenHeight / 2,
                    color: Colors.grey.shade900,
                    child: Container(
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Visibility(
                              visible: gameStarted && blacksMove,
                              child: FloatingActionButton(
                                onPressed: () {
                                  setState(() {
                                    gamePaused = true;
                                    gameStarted = false;
                                  });
                                  stopBlackTimer();
                                },
                                child: Icon(Icons.pause),
                                heroTag: null,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Transform.rotate(
                                angle: math.pi,
                                child:Text(
                                  blacksTimeUp? "TIME UP" : blackBuildTime(),
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: Colors.white54,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: whitesMove
                        ? () async {
                            await player.setAsset('assets/audio/tap.mp3');
                            player.play();
                            setState(() {
                              whitesMove = false;
                              blacksMove = true;
                            });
                            stopWhiteTimer();
                            startBlackTimer();
                          }
                        : () => null,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      width: _screenWidth,
                      height: gameStarted
                          ? blacksMove
                              ? 80
                              : _screenHeight - 80
                          : _screenHeight / 2,
                      color: Colors.grey.shade700,
                      child: Container(
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                  child:Text(
                                whitesTimeUp? "TIME UP" : whiteBuildTime(),
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.grey.shade900,
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Visibility(
                                visible: gameStarted && whitesMove,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      gamePaused = true;
                                      gameStarted = false;
                                    });
                                    stopWhiteTimer();
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
                      //@ Start The Game ( Work on It on the morning)
                      if(timeup){
                        reset();
                      }else{
                        if (gamePaused) {
                          if(whitesMove){
                            startWhiteTimer();
                            setState(() {
                              gameStarted = true;
                              whitesMove = true;
                              blacksMove = false;
                            });
                          }else{
                            startBlackTimer();
                            setState(() {
                              gameStarted = true;
                              whitesMove = false;
                              blacksMove = true;
                            });
                          }
                        } else {
                          startWhiteTimer();
                          setState(() {
                            gameStarted = true;
                            whitesMove = true;
                            blacksMove = false;
                          });
                        }
                      }

                    },
                    child: Icon(timeup? Icons.replay_outlined : Icons.play_arrow),
                    heroTag: null,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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

  void startWhiteTimer() {
    whiteTimer = Timer.periodic(Duration(seconds: 1), (_) => addWhiteTime());
  }

  void startBlackTimer() {
    blackTimer = Timer.periodic(Duration(seconds: 1), (_) => addBlackTime());
  }

  void addWhiteTime({ Duration inc = const Duration(seconds: 0),int countingDown = -1}) {
    final addSeconds = countingDown + inc.inSeconds;
    setState(() {
      final seconds = whiteDuration.inSeconds + addSeconds;
      if (seconds < 0) {
        setState(() {
          whitesTimeUp = true;
          timeup=true;
          gameStarted=false;
        });
        whiteTimer?.cancel();
      } else {
        whiteDuration = Duration(seconds: seconds);
      }
    });
  }

  void addBlackTime({ Duration inc = const Duration(seconds: 0),int countingDown = -1 }) {
    final addSeconds = countingDown + inc.inSeconds;
    setState(() {
      final seconds = blackDuration.inSeconds + addSeconds;
      if (seconds < 0) {
        setState(() {
          blacksTimeUp = true;
          timeup=true;
          gameStarted=false;
        });
        blackTimer?.cancel();
      } else {
        blackDuration = Duration(seconds: seconds);
      }
    });
  }

  String blackBuildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(blackDuration.inHours);
    final minutes = twoDigits(blackDuration.inMinutes.remainder(60));
    final seconds = twoDigits(blackDuration.inSeconds.remainder(60));
    return '${hours}:${minutes}:${seconds}';
  }

  String whiteBuildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(whiteDuration.inHours);
    final minutes = twoDigits(whiteDuration.inMinutes.remainder(60));
    final seconds = twoDigits(whiteDuration.inSeconds.remainder(60));
    return '${hours}:${minutes}:${seconds}';
  }

  void stopWhiteTimer() {
    if(blacksMove){
      addWhiteTime(inc: widget.increment,countingDown: 0);
    }
    setState(() => whiteTimer?.cancel());
  }

  void stopBlackTimer() {
    if(whitesMove){
      addBlackTime(inc: widget.increment,countingDown: 0);
    }
    setState(() => blackTimer?.cancel());
  }
}