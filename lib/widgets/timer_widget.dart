import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 80,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            '2:30',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }
}
