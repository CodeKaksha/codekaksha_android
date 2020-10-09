import 'package:flutter/material.dart';
import 'package:whiteboardkit/whiteboardkit.dart';

class MyWhiteboard extends StatefulWidget {
  @override
  _MyWhiteboardState createState() => _MyWhiteboardState();
}

class _MyWhiteboardState extends State<MyWhiteboard>
    with AutomaticKeepAliveClientMixin<MyWhiteboard> {
  @override
  bool get wantKeepAlive => true;
  //Since the whiteboard is part of the TabBar, switching to a new tab reloads the tab.
  //mixin and AutomaticKeepAliveClientMixin we can add persistence to a widget.
  //Set wantKeepAlive to true, add an initState, and call super.build(context) from build Widget

  DrawingController controller;

  @override
  void initState() {
    controller = new DrawingController();
    controller.onChange().listen((draw) {
      //do something with it
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      //Scaffold being a material widget is needed to open the whiteboard
      //from the drawer
      body: Whiteboard(
        controller: controller,
      ),
    );
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
}
