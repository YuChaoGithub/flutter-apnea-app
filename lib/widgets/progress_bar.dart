import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: FAProgressBar(
        currentValue: 50,
        maxValue: 100,
        direction: Axis.horizontal,
        size: 10,
        progressColor: Theme.of(context).textTheme.title.color,
        backgroundColor: Colors.black12,
      ),
    );
  }
}
