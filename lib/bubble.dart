import 'dart:ui';

import 'model/task.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bubble extends StatefulWidget {
  @override
  _BubbleState createState() => _BubbleState();

  /// children tasks from low to high
  final List<Widget> children;

  /// the speed of the animation
  final int animationSpeed;

  Bubble({this.children = const [], this.animationSpeed = 150});
}

class _BubbleState extends State<Bubble> with SingleTickerProviderStateMixin {
  double yOffset = 175.0;
  double xOffset = 50.0;

  ScrollController _controller;
  AnimationController _animationController;
  double _open = 1;

  List<Task> tasks = [
    new Task(name: "Laundry", done: false, description: ""),
    new Task(name: "hide", done: false, description: ""),
    new Task(name: "yeah", done: false, description: ""),
    new Task(name: "yeah", done: false, description: ""),
    new Task(name: "yeah", done: false, description: ""),
  ];

  /* necessary due to list builder error: Future is already... */
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
    _animationController = AnimationController(
      duration: _calculateMainControllerDuration(),
      vsync: this,
    );
    _controller = ScrollController();
    _controller.addListener(_scrollListener); //the listener for up and down.
  }

  Duration _calculateMainControllerDuration() => Duration(
      milliseconds: widget.animationSpeed +
          widget.children.length * (widget.animationSpeed / 5).round());

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _performAnimation() {
    if (!mounted) return;
    if (_open == 0) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    /* positioning of bubble dynamically */
    return Positioned(
      top: yOffset,
      left: xOffset,

      /* make bubble draggable */
      child: Listener(
        onPointerDown: (PointerDownEvent event) {
          print(event.position);
        },
        onPointerMove: (PointerMoveEvent event) {
          print(event.position);
        },
        child: Draggable<Widget>(
          /* drag functon */
          onDraggableCanceled: (velocity, offset) {
            setState(() {
              yOffset = offset.dy;
              xOffset = offset.dx;
            });
          },

          /* bubble when being dragged */
          feedback: FloatingActionButton(
            backgroundColor: Color.fromRGBO(61, 179, 221, 1),
            onPressed: () {},
          ),

          /* element left behind, it's a container for it to be invisible */
          childWhenDragging: Container(),

          /* stack of elements that shape the bubble task */
          child: Stack(
            children: [
              /* tasks object, hid when _hide is 1 */
              Opacity(
                opacity: _open,

                /* container over list for it to have a layout, don't know why */
                child: Container(
                  height: 300,
                  width: 300,

                  /* dynamic list of tasks */
                  child: ListView.builder(
                    /* scrolling controller */
                    controller: _controller,
                    itemCount: tasks.length,
                    shrinkWrap: true,

                    /* invisible container, with icon and label on a row */
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

              /* button that is shown always inside the stack */
              FloatingActionButton(
                backgroundColor: Color.fromRGBO(61, 179, 221, 1),
                onPressed: () {
                  setState(() {
                    _open = (_open == 1) ? 0 : 1;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
