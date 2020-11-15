import 'dart:ui';

import 'model/task.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bubble extends StatefulWidget {
  @override
  _BubbleState createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  double yOffset = 175.0;
  double xOffset = 50.0;

  double hide = 1;

  List<Task> tasks = [
    new Task(name: "Laundry", done: false, description: ""),
    new Task(name: "hide", done: false, description: ""),
    new Task(name: "yeah", done: false, description: ""),
    new Task(name: "yeah", done: false, description: ""),
    new Task(name: "yeah", done: false, description: ""),
  ];

  ScrollController _controller;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        print("hello");
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener); //the listener for up and down.
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yOffset,
      left: xOffset,
      child: Draggable<Widget>(
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            yOffset = offset.dy;
            xOffset = offset.dx;
          });
        },
        feedback: FloatingActionButton(
          backgroundColor: Color.fromRGBO(61, 179, 221, 1),
          onPressed: () {},
        ),
        childWhenDragging: Opacity(
          opacity: 0.1,
          child: FloatingActionButton(
            backgroundColor: Color.fromRGBO(61, 179, 221, 1),
            onPressed: () {},
          ),
        ),
        child: Stack(
          children: [
            Opacity(
              opacity: hide,
              child: Container(
                height: 300,
                width: 300,
                child: ListView.builder(
                  controller: _controller,
                  itemCount: tasks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Material(
                    child: InkWell(
                      onTap: () {
                        print(tasks[index].name);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(22, /*40*/ 0, 0, 0),
                        decoration: BoxDecoration(color: Colors.white),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 265.0, top: 10, bottom: 0, left: 0),
                              child: Container(
                                height: 20.0,
                                width: 0.2,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 13,
                                  color: Color.fromRGBO(61, 179, 221, 1),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10)),
                                Text(
                                  tasks[index].name,
                                  style: GoogleFonts.muli(
                                    fontSize: 14,
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              backgroundColor: Color.fromRGBO(61, 179, 221, 1),
              onPressed: () {
                setState(() {
                  hide = (hide == 1) ? 0 : 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
