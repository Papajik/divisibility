import 'package:divisibility_calculator/models/division_model.dart';
import 'package:flutter/material.dart';

class CalculationPage extends StatelessWidget {
  final DivisionModel divisionModel;
  const CalculationPage({Key? key, required this.divisionModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Výpočet dělitelnosti pro dělitel ${divisionModel.divider} v systému ${divisionModel.system}"),
        centerTitle: true,
      ),
      body:  ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: divisionModel.calculations.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 30,
              child: Center(
                  child: Text(divisionModel.calculations[index])),
            );
          }),
    );
  }
}
