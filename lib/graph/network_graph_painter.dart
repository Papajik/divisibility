import 'dart:math';

import 'package:flutter/material.dart';

class NetworkGraphPainter extends CustomPainter {
  final Map<String, String> map;
  final int maxRemainder;
  final Paint unusedNode = Paint()..color = Colors.grey;
  final Paint usedNode = Paint()..color = Colors.blue.shade300;
  final Paint line = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5.0;

  @override
  void paint(Canvas canvas, Size size) {
    print(map);
    var centerX = size.width / 2;
    var centerY = size.height / 2;

    var radius = min(centerX, centerY) - 50;

    /// Nakreslit body

    var step = 360 / maxRemainder;
    var nodePositionRadius = radius - 15;
    var nodeRadius = radius / 10;
    var index = 0;

    /// Vykreslení linky mezi uzly
    for (int i = 0; i<maxRemainder;i++){
      if (map.containsKey(i.toString())) {
        paintLine(canvas, step, i, centerX, nodePositionRadius);
      }
    }


    for (double i = 0; i < 360; i += step) {
      /// Pozice uzlu
      var x = centerX + nodePositionRadius * cos(i * pi / 180);
      var y = centerX + nodePositionRadius * sin(i * pi / 180);

      /// Vykreslení uzlu
      paintNode(canvas, Offset(x, y), nodeRadius, index);
      paintNodeName(index, size, canvas, Offset(x, y));

      index++;
    }
  }

  Offset calcOffsetFromIndex(
      double step, int index, double centerX, double nodePositionRadius) {
    var i = step * index;
    var x = centerX + nodePositionRadius * cos(i * pi / 180);
    var y = centerX + nodePositionRadius * sin(i * pi / 180);

    return Offset(x, y);
  }

  void paintLine(Canvas canvas, double step, int index, double centerX,
      double nodePositionRadius) {
    var offsetFrom =
        calcOffsetFromIndex(step, index, centerX, nodePositionRadius);

    int indexTo = int.tryParse(map[index.toString()] ?? "") ?? -1;
    if (indexTo == -1) {
      return;
    }
    var offsetTo =
        calcOffsetFromIndex(step, indexTo, centerX, nodePositionRadius);

    var path = Path();
    path.moveTo(offsetFrom.dx, offsetFrom.dy);
    path.lineTo(offsetTo.dx, offsetTo.dy);
    canvas.drawPath(path, line);
  }

  void paintNodeName(int index, Size size, Canvas canvas, Offset offset) {
    var text = TextSpan(
        text: index.toString(),
        style: const TextStyle(color: Colors.black, fontSize: 30));
    final textPainter = TextPainter(
      text: text,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    textPainter.paint(
        canvas,
        Offset(offset.dx - (textPainter.width / 2),
            offset.dy - (textPainter.height / 2)));
  }

  void paintNode(Canvas canvas, Offset offset, double nodeRadius, int index) {
    canvas.drawCircle(
        offset,
        nodeRadius,
        map.containsKey(index.toString()) || map.containsValue(index.toString())
            ? usedNode
            : unusedNode);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  NetworkGraphPainter({required this.map, required this.maxRemainder});
}
