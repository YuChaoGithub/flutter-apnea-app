import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class InspireButton extends StatelessWidget {
  static const _clipCount = 9;
  final Random random = Random(DateTime.now().millisecondsSinceEpoch);
  final AudioCache audioCache = AudioCache(prefix: 'audio/inspire/');

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/icons/inspire.png',
        color: Theme.of(context).iconTheme.color,
      ),
      onPressed: () => audioCache.play("${random.nextInt(_clipCount) + 1}.wav"),
    );
  }
}
