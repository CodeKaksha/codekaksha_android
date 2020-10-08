import 'package:flutter/material.dart';

class Whiteboard extends StatefulWidget {
  @override
  _WhiteboardState createState() => _WhiteboardState();
}

class _WhiteboardState extends State<Whiteboard>
    with AutomaticKeepAliveClientMixin<Whiteboard> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  //Since the whiteboard is part of the TabBar, switching to a new tab reloads the tab.
  //mixin and AutomaticKeepAliveClientMixin we can add persistence to a widget.
  //Set wantKeepAlive to true, add an initState, and call super.build(context) from build Widget

  List<Offset> _points = <Offset>[];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            //onPanUpdate keeps track of pointer motion
            setState(() {
              RenderBox object = context.findRenderObject();
              //Container is the RenderObject in this context

              Offset _localPosition =
                  object.globalToLocal(details.globalPosition);

              _points = List.from(_points)..add(_localPosition);
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          //Keeps track of when the pointer stops

          child: CustomPaint(
            painter: DrawMyLine(
              points: _points,
            ),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _points.clear();
        },
        child: Icon(Icons.clear),
      ),
    );
  }
}

class DrawMyLine extends CustomPainter {
  List<Offset> points;

  DrawMyLine({this.points});
  //constructor

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        new Paint() //to use cascade operator, new Paint() must be specified
          ..color = Colors.black
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; ++i) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(DrawMyLine oldDelegate) => oldDelegate.points != points;
  //oldDelegate is set to CustomPainter type by default
  //returns true if the points should be repainted
}
