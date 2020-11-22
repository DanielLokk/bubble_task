import 'package:bubble_task_flutter/bubble.dart';
import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(BubbleTaskApp());
}

class BubbleTaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Bubble(),
            SpeedDial(
              marginRight: 50,
              marginBottom: 50,
              animatedIcon: AnimatedIcons.menu_close,
              backgroundColor: Colors.amber,
              animationSpeed: 100,
              shape: CircleBorder(),
              children: [
                SpeedDialChild(),
                SpeedDialChild(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
