import 'package:flutter/material.dart';

class NetworkGraphPainter extends CustomPainter {
  Map<String, String> map;

  @override
  void paint(Canvas canvas, Size size) {
    var center = size / 2;
    var paint = Paint()..color = Colors.red;
    canvas.drawCircle(Offset(center.width, center.height), 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  NetworkGraphPainter(this.map);
}
