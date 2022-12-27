import 'package:divisibility_calculator/models/basic_formula.dart';
import 'package:divisibility_calculator/models/division_formula.dart';
import 'package:divisibility_calculator/models/division_model.dart';
import 'package:divisibility_calculator/models/network_graph.dart';
import 'package:divisibility_calculator/pages/divisibilityCalculator/calulactionPage.dart';
import 'package:divisibility_calculator/pages/divisibilityCalculator/verificationPage.dart';
import 'package:divisibility_calculator/widgets/formula_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DivisibilityEquationGeneratorScreen extends ConsumerStatefulWidget {
  const DivisibilityEquationGeneratorScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DivisibilityEquationGeneratorScreen> createState() =>
      _DivisibilityEquationGeneratorScreenState();
}

class _DivisibilityEquationGeneratorScreenState
    extends ConsumerState<DivisibilityEquationGeneratorScreen> {
  static const DEFAULT_BASE = 10;
  static const DEFAULT_DIVIDER = 3;

  final divisionModelProvider =
      StateNotifierProvider<DivisionModelNotifier, DivisionModel>((ref) {
    return DivisionModelNotifier(DEFAULT_BASE, DEFAULT_DIVIDER);
  });

  final networkGraphModelProvider =
      StateNotifierProvider<NetworkGraphModel, Map<String, String>>(
    (ref) => NetworkGraphModel([]),
  );

  final basicFormulaModelProvider =
      StateNotifierProvider<BasicFormulaModel, String>(
    (ref) => BasicFormulaModel(0, DEFAULT_BASE),
  );

  final divisionFormulaModelProvider =
      StateNotifierProvider<DivisionFormulaModel, String>(
    (ref) => DivisionFormulaModel([], DEFAULT_BASE),
  );

  late final TextEditingController dividerController;

  late final TextEditingController numberSystemController;

  @override
  void initState() {
    super.initState();
    dividerController = TextEditingController(
        text: ref.read(divisionModelProvider).divider.toString());
    numberSystemController = TextEditingController(
        text: ref.read(divisionModelProvider).system.toString());
  }

  @override
  Widget build(BuildContext context) {
    DivisionModel divisionModel = ref.watch(divisionModelProvider);
    ref.listen(divisionModelProvider, (previous, next) {
      ref
          .read(basicFormulaModelProvider.notifier)
          .generate(next.calculations.length, next.system);
      ref
          .read(divisionFormulaModelProvider.notifier)
          .generate(next.remainders, next.system);
    });

    return Padding(
      padding: const EdgeInsets.only(top: 50.0, left: 40),
      child: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // width: 500,
              child: FormulaCard(children: [
                const Text('Vstupní data'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        decoration: const InputDecoration(labelText: "Dělitel"),
                        controller: dividerController,
                        onChanged: (value) {
                          if (value == "") {
                            value = "1";
                          }
                          ref
                              .read(divisionModelProvider.notifier)
                              .setDivider(int.parse(value));
                        },
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(5),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: Consumer(builder: (context, watch, _) {
                        // Note here, state does not need to be specified.
                        final s =
                            ref.watch(divisionModelProvider).dividerInBase;
                        return Text(s);
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                  child: TextField(
                    decoration: const InputDecoration(labelText: "Soustava"),
                    controller: numberSystemController,
                    onChanged: (value) {
                      if (value == "") {
                        value = "1";
                      }
                      ref
                          .read(divisionModelProvider.notifier)
                          .setSystem(int.parse(value));
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                  ),
                )
              ]),
            ),

            if (ref.read(basicFormulaModelProvider.notifier).formula != "")
              FormulaCard(children: [
                const Text("Základní rovnice"),
                Text(ref.watch(basicFormulaModelProvider)),
              ]),

            if (ref.read(divisionFormulaModelProvider.notifier).formula != "")
              FormulaCard(children: [
                const Text("Výsledná rovnice"),
                Text(ref.watch(divisionFormulaModelProvider))
              ]),

            if (divisionModel.remainders.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            CalculationPage(divisionModel: divisionModel)));
                  },
                  child: const Text('Zobrazit výpočet'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CalculationPage(divisionModel: divisionModel)),
                    );
                  },
                  child: const Text('Grafické znázornění'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerificationPage(
                                divisionModel: divisionModel,
                                divisionFormulaModel: ref.read(
                                    divisionFormulaModelProvider.notifier),
                              )),
                    );
                  },
                  child: const Text('Ověření dělitelnosti'),
                ),
              ),
            ]

            // SizedBox(height: 400, child: CustomPaint(
            //   painter:NetworkGraphPainter(ref.watch(networkGraphModelProvider)),
            // ))
          ],
        ),
      ),
    );
  }
}
