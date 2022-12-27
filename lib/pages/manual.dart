import 'package:divisibility_calculator/widgets/formula_card.dart';
import 'package:flutter/material.dart';

class ManualScreen extends StatefulWidget {
  const ManualScreen({Key? key}) : super(key: key);

  @override
  State<ManualScreen> createState() => _ManualScreenState();
}

class _ManualScreenState extends State<ManualScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        FormulaCard(
          children: [Text('Pravidla')],
        )
      ],
    );
  }
}
