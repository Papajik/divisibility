import 'package:divisibility_calculator/graph/network_graph_painter.dart';
import 'package:divisibility_calculator/models/division_model.dart';
import 'package:divisibility_calculator/models/network_graph.dart';
import 'package:flutter/material.dart';

class NetworkGraphPage extends StatelessWidget {
  final DivisionModel divisionModel;

  const NetworkGraphPage({Key? key, required this.divisionModel})
      : super(key: key);



  @override
  Widget build(BuildContext context) {

    NetworkGraphModel model =  NetworkGraphModel(divisionModel.remainders);
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Grafické znázornění pro dělitele ${divisionModel.divider} v systému ${divisionModel.system}"),
          centerTitle: true,
        ),
        body: Center(
          child: SizedBox(
              height: 600,
              width: 600,
              child: CustomPaint(
                painter:
                    NetworkGraphPainter(map: model.networkMap, maxRemainder: divisionModel.divider),
              )),
        ));
  }
}
