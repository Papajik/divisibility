import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DivisibilityCheckScreen extends StatefulWidget {
  const DivisibilityCheckScreen({Key? key}) : super(key: key);

  @override
  State<DivisibilityCheckScreen> createState() =>
      _DivisibilityCheckScreenState();
}

class _DivisibilityCheckScreenState extends State<DivisibilityCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 100,
              child: TextField(
                decoration: const InputDecoration(labelText: "Dělitel"),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                decoration: const InputDecoration(labelText: "Základ"),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            )
          ],
        )
      ],
    );
  }
}
