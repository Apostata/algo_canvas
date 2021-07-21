import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Algo Canvas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: CanvasPage(),
    );
  }
}

class CanvasPage extends StatelessWidget {
  const CanvasPage({Key? key}) : super(key: key);

  final totalPadding = 16 * 2;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    // Actual canvas area to be used for drawing
    double canvasWidth = MediaQuery.of(context).size.width - totalPadding;
    double canvasHeight =
        MediaQuery.of(context).size.height - totalPadding - statusBarHeight;

    // Taking each box side to be 30 pixels
    var eachBoxSize = 30.0;

    // Calculating the number of lines to be drawn
    var numberOfBoxesAlongWidth = canvasWidth ~/ eachBoxSize;
    var numberOfLinesAlongWidth = numberOfBoxesAlongWidth;

    var numberOfBoxesAlongHeight = canvasHeight ~/ eachBoxSize;
    var numberOfLinesAlongHeight = numberOfBoxesAlongHeight; // +1

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomPaint(
            painter: GridPainter(
              eachBoxSize: eachBoxSize,
              numberOfLinesAlongWidth: numberOfLinesAlongWidth,
              numberOfLinesAlongHeight: numberOfLinesAlongHeight,
            ),
            foregroundPainter: PolygonPainter(),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final double eachBoxSize;
  final int numberOfLinesAlongWidth;
  final int numberOfLinesAlongHeight;

  GridPainter({
    required this.eachBoxSize,
    required this.numberOfLinesAlongWidth,
    required this.numberOfLinesAlongHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Horizontal initial offsets
    var startPointHorizontal = Offset(0, 0);
    var endPointHorizontal = Offset(numberOfLinesAlongWidth * eachBoxSize, 0);

    // Vertical initial offsets
    var startPointVertical = Offset(0, 0);
    var endPointVertical = Offset(0, numberOfLinesAlongHeight * eachBoxSize);

    // Painter style
    var axisPaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // Draw axes
    for (int i = 0; i <= numberOfLinesAlongHeight; i++) {
      canvas.drawLine(startPointHorizontal, endPointHorizontal, axisPaint);
      canvas.drawLine(startPointVertical, endPointVertical, axisPaint);

      // horizontal increment
      var incrementHorizontal = Offset(0, eachBoxSize);
      startPointHorizontal += incrementHorizontal;
      endPointHorizontal += incrementHorizontal;

      // vertical increment
      var incrementVertical = Offset(eachBoxSize, 0);
      startPointVertical += incrementVertical;
      endPointVertical += incrementVertical;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Not repainting now
    return false;
  }
}

class PolygonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
