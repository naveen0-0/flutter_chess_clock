class Clock{
  String name;
  Duration time;
  Duration increment;

  Clock({ required this.name, required this.time, required this.increment });

  static List<Clock> clocks = [
    Clock(name: "Bullet", time: Duration(minutes: 1), increment: Duration(seconds:0)),
    Clock(name: "Bullet", time: Duration(minutes: 2), increment: Duration(seconds:1)),
    Clock(name: "Blitz", time: Duration(minutes: 3), increment: Duration(seconds:0)),
    Clock(name: "Blitz", time: Duration(minutes: 3), increment: Duration(seconds:2)),
    Clock(name: "Blitz", time: Duration(minutes: 5), increment: Duration(seconds:0)),
    Clock(name: "Blitz", time: Duration(minutes: 5), increment: Duration(seconds:5)),
    Clock(name: "Rapid", time: Duration(minutes: 10), increment: Duration(seconds:0)),
    Clock(name: "Rapid", time: Duration(minutes: 10), increment: Duration(seconds:10)),
    Clock(name: "Clasical", time: Duration(minutes: 15), increment: Duration(seconds:0)),
    Clock(name: "Clasical", time: Duration(minutes: 15), increment: Duration(seconds:15)),
  ];
}