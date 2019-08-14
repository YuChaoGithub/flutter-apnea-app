import 'package:flutter/material.dart';

import '../models/minute_second.dart';

class TimerViewWidget extends StatelessWidget {
  final MinuteSecond currTime;

  TimerViewWidget(this.currTime);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 80,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).textTheme.button.color,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            currTime.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Exo',
            ),
          ),
        ),
      ),
    );
  }
}
