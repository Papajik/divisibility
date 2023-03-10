import 'package:divisibility_calculator/models/basic_formula.dart';
import 'package:divisibility_calculator/models/division_formula.dart';
import 'package:divisibility_calculator/models/division_model.dart';
import 'package:divisibility_calculator/pages/divisibilityCalculator/calculationPage.dart';
import 'package:divisibility_calculator/pages/divisibilityCalculator/graphPage.dart';
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
  static const DEFAULT_DIVIDER = 7;

  final divisionModelProvider =
      StateNotifierProvider<DivisionModelNotifier, DivisionModel>((ref) {
    return DivisionModelNotifier(DEFAULT_BASE, DEFAULT_DIVIDER);
  });


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
                const Text('Vstupn?? data'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextField(
                        decoration: const InputDecoration(labelText: "D??litel"),
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
                const Text("Obecn?? rovnice"),
                Text(ref.watch(basicFormulaModelProvider)),
              ]),

            if (ref.read(divisionFormulaModelProvider.notifier).formula != "")
              FormulaCard(children: [
                const Text("V??sledn?? rovnice pro ov????en?? d??litelnosti"),
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
                  child: const Text('Zobrazit v??po??et'),
                ),
              ),
              if (divisionModel.divider < 25)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NetworkGraphPage(divisionModel: divisionModel)),
                      );
                    },
                    child: const Text('Grafick?? zn??zorn??n?? cyklu'),
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
                  child: const Text('Ov????en?? d??litelnosti'),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
