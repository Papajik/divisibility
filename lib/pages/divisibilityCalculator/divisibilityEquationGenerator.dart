import 'package:divisibility_calculator/graph/network_graph_painter.dart';
import 'package:divisibility_calculator/models/basic_formula.dart';
import 'package:divisibility_calculator/models/division_model.dart';
import 'package:divisibility_calculator/models/network_graph.dart';
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
  final divisionModelProvider =
      StateNotifierProvider<DivisionModelNotifier, DivisionModel>((ref) {
    return DivisionModelNotifier(10, 1);
  });


  final networkGraphModelProvider = StateNotifierProvider<NetworkGraphModel,Map<String, String>>(
        (ref) => NetworkGraphModel([]),
  );

  final basicFormulaModelProvider = StateNotifierProvider<BasicFormulaModel,String>(
        (ref) => BasicFormulaModel(0),
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
        ref.read(basicFormulaModelProvider.notifier).generate(next.calculations.length);
    });


    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: Row(
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
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  const SizedBox(
                    width: 50,
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Rozbor"),
            ),
            Text(ref.watch(basicFormulaModelProvider)),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Výpočet"),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: divisionModel.calculations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 30,
                        child: Center(child: Text(divisionModel.calculations[index])),
                      );
                    }),
              ),
            ),
            SizedBox(height: 400, child: CustomPaint(
              painter:NetworkGraphPainter(ref.watch(networkGraphModelProvider)),
            ))
          ],
        ),
      ),
    );
  }
}
