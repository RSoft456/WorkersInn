import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:workers_inn/variables.dart';

class CountDown extends StatefulWidget {
  const CountDown({super.key});

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  final int duration = 11;
  final CountDownController _controller = CountDownController();
  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: duration,
      controller: _controller,
      // initialDuration: 10,
      fillColor: orange,
      strokeWidth: 0.7,
      strokeCap: StrokeCap.round,
      height: MediaQuery.of(context).size.width * 0.09,
      ringColor: orange,
      width: MediaQuery.of(context).size.width * 0.09,
      textStyle: TextStyle(
        // fontSize: 33.0,
        color: orange,
        fontWeight: FontWeight.bold,
      ),

      textFormat: CountdownTextFormat.S,

      isReverse: true,
      isReverseAnimation: true,
      isTimerTextShown: true,

      autoStart: true,

      // This Callback will execute when the Countdown Starts.
      onStart: () {
        // Here, do whatever you want
        debugPrint('Countdown Started');
      },

      // This Callback will execute when the Countdown Ends.
      onComplete: () {
        // Here, do whatever you want
        debugPrint('Countdown Ended');
      },

      // This Callback will execute when the Countdown Changes.
      onChange: (String timeStamp) {
        // Here, do whatever you want
        debugPrint('Countdown Changed $timeStamp');
      },
      // timeFormatterFunction: (defaultFormatterFunction, duration) {
      //   if (duration.inSeconds == 0) {
      //     // only format for '0'
      //     return "0";
      //   } else {
      //     // other durations by it's default format
      //     return Function.apply(defaultFormatterFunction, [duration]);
      //   }
      //},
    );
  }
}
