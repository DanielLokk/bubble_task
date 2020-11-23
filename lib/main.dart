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
          /* elements on the screen */
          children: [
            Bubble(),

            /* add button */
            SpeedDial(
              /* positioning add button */
              marginRight: 50,
              marginBottom: 50,

              /* decoration add button */
              animatedIcon: AnimatedIcons.menu_close,
              backgroundColor: Colors.amber,
              animationSpeed: 250,
              shape: CircleBorder(),

              /* add task or bubble buttons */
              children: [
                SpeedDialChild(
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.bubble_chart),
                ),
                SpeedDialChild(
                    backgroundColor: Colors.amber, child: Icon(Icons.add)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
