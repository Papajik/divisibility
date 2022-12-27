import 'package:flutter/material.dart';


class FormulaCard extends StatelessWidget {
  final List<Widget> children;
  final double? height;
  final Color? color;

  const FormulaCard({
    Key? key,
    this.height,
    required this.children, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Card(
        child: Container(
          color: color,
          child: SizedBox(
            width: 500,
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
