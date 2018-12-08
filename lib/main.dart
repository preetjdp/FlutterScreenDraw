import 'package:flutter/material.dart';

void main() => runApp( MaterialApp(
  home: HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Offset> _points = <Offset> [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
                          RenderBox object = context.findRenderObject();
                          Offset _localPosition = object.globalToLocal(details.globalPosition);
                          _points = List.from(_points)..add(_localPosition);
                        });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
          child: CustomPaint(
            painter: Signature(points: _points),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
          _points.clear();
        },
      ),
    );
  }
}

class Signature extends CustomPainter {

  List<Offset> points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint()
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5.0;
    

    for(int i = 0; i < points.length - 1 ; i++ ) {
      if(points[i] != null && points[i+1] != null) {
        canvas.drawLine(points[i], points[i+1], paint);
      }
    }

  }

  @override
  bool shouldRepaint(Signature oldDelegate) {
    return oldDelegate.points != points;
  }

}