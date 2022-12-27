import 'package:divisibility_calculator/models/division_formula.dart';
import 'package:divisibility_calculator/models/division_model.dart';
import 'package:divisibility_calculator/models/verify_model.dart';
import 'package:divisibility_calculator/utils/alphabet.dart';
import 'package:divisibility_calculator/utils/number.dart';
import 'package:divisibility_calculator/widgets/formula_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationPage extends ConsumerStatefulWidget {
  // final VerificationModel verificationModel;
  final DivisionModel divisionModel;
  final DivisionFormulaModel divisionFormulaModel;

  const VerificationPage(
      {Key? key,
      required this.divisionModel,
      required this.divisionFormulaModel})
      : super(key: key);

  @override
  ConsumerState<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends ConsumerState<VerificationPage> {
  late final verificationModelProvider =
      StateNotifierProvider<VerificationModel, List<String>>(
    (ref) => VerificationModel(widget.divisionModel.remainders, "10",
        widget.divisionModel.divider, widget.divisionModel.system),
  );
  late final TextEditingController verificationController;
  late final TextEditingController verificationBaseController;

  @override
  void initState() {
    super.initState();
    verificationController = TextEditingController(
        text: Number.decimalToBase(10, widget.divisionModel.system));
    verificationBaseController = TextEditingController(text: "10");
  }

  @override
  Widget build(BuildContext context) {
    List<String> verificationList = ref.watch(verificationModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Ověření dělitelnosti dělitelem ${widget.divisionModel.divider} v systému ${widget.divisionModel.system}"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, top: 50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormulaCard(children: [
                const Text("Rovnice"),
                Text(widget.divisionFormulaModel.formula)
              ]),
              if (widget.divisionModel.system != 10)
                FormulaCard(
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText:
                                "Ověření výsledku pro (${Alphabet.toSubscript("10")}): "),
                        controller: verificationBaseController,
                        onChanged: (value) {
                          if (value == "") {
                            value = "1";
                          }
                          verificationController.text = Number.decimalToBase(
                              int.parse(value), widget.divisionModel.system);
                          ref.read(verificationModelProvider.notifier).verify(
                              widget.divisionModel.remainders.reversed.toList(),
                              verificationController.text,
                              widget.divisionModel.divider,
                              widget.divisionModel.system);
                        },
                        // keyboardType:
                        //     const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[0-9a-zA-Z]")),
                        ],
                      ),
                    )
                  ],
                ),
              FormulaCard(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      decoration: InputDecoration(
                          labelText:
                              "Ověření výsledku pro (${Alphabet.toSubscript(widget.divisionModel.system.toString())}): "),
                      controller: verificationController,
                      onChanged: (value) {
                        if (value == "") {
                          value = "1";
                        }

                        verificationBaseController.text = Number.baseToDecimal(
                            value, widget.divisionModel.system);
                        ref.read(verificationModelProvider.notifier).verify(
                            widget.divisionModel.remainders.reversed.toList(),
                            value,
                            widget.divisionModel.divider,
                            widget.divisionModel.system);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z]")),
                      ],
                    ),
                  )
                ],
              ),
              if (verificationList.isNotEmpty) ...[
                FormulaCard(
                  color: verificationList.length != 3
                      ? null
                      : verificationList[2] == "Číslo je dělitelné"
                          ? Colors.lightGreen.shade100
                          : Colors.red.shade50,
                  children: [
                    Text(verificationList[0]),
                    if (verificationList.length == 3) ...[
                      Text(verificationList[1]),
                      Text(verificationList[2]),
                    ]
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}
