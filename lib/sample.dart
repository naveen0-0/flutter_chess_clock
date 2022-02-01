import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_stopwatch_timer_demo/button_widget.dart';

class StopWatchTimerPage extends StatefulWidget {
  @override
  _StopWatchTimerPageState createState() => _StopWatchTimerPageState();
}

class _StopWatchTimerPageState extends State<StopWatchTimerPage> {
  static const countdownDuration = Duration(minutes: 10);
  Duration duration = Duration();
  Timer? timer;

  bool countDown =true;

  @override
  void initState() {
    super.initState();
    reset();
  }

  void reset(){
    if (countDown){
      setState(() =>
        duration = countdownDuration);
    } else{
      setState(() =>
        duration = Duration());
    }
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1),(_) => addTime());
  }

  void addTime(){
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0){
        timer?.cancel();
      } else{
        duration = Duration(seconds: seconds);

      }
    });
  }

  void stopTimer({bool resets = true}){
    if (resets){
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.orange[500],
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Text("Flutter StopWatch Timer Demo"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTime(),
          SizedBox(height: 80,),
          buildButtons()
        ],
      ),
    ),
  );

  Widget buildTime(){
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final hours =twoDigits(duration.inHours);
    final minutes =twoDigits(duration.inMinutes.remainder(60));
    final seconds =twoDigits(duration.inSeconds.remainder(60));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header:'HOURS'),
        SizedBox(width: 8,),
       buildTimeCard(time: minutes, header:'MINUTES'),
       SizedBox(width: 8,),
       buildTimeCard(time: seconds, header:'SECONDS'),
    ]
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Text(
            time, style: TextStyle(fontWeight: FontWeight.bold,
            color: Colors.black,fontSize: 50),),
          ),
          SizedBox(height: 24,),
          Text(header,style: TextStyle(color: Colors.black45)),
        ],
      );

  Widget buildButtons(){
    final isRunning = timer == null? false: timer!.isActive;
    final isCompleted = duration.inSeconds == 0;
     return isRunning || isCompleted
         ? Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         ButtonWidget(
             text:'STOP',
             onClicked: (){
               if (isRunning){
                 stopTimer(resets: false);
               }
             }),
         SizedBox(width: 12,),
         ButtonWidget(
             text: "CANCEL",
             onClicked: stopTimer
         ),
       ],
     )
         : ButtonWidget(
         text: "Start Timer!",
         color: Colors.black,
         backgroundColor: Colors.white,
         onClicked: (){
           startTimer();
         });

  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const ButtonWidget({Key? key, required this.text, required this.onClicked,
    this.color = Colors.white, this.backgroundColor = Colors.black}) : super(key: key);
  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)
    ),
      onPressed: onClicked,
      child: Text(text,style: TextStyle(fontSize: 20,color: color),)
  );

}