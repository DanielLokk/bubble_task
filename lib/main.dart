import 'package:bubble_task_flutter/bubble.dart';
import 'package:flutter/material.dart';

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
        body: Stack(children: [
          Bubble(),
        ]),
      ),
    );
  }
}
