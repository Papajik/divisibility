import 'package:divisibility_calculator/utils/alphabet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DivisionFormulaModel extends StateNotifier<String> {
  DivisionFormulaModel(List<int> remainders, int base)
      : super(generateFormula(remainders, base));

  void generate(List<int> remainders, int base) {
    state = generateFormula(remainders, base);
  }

  String get formula => state;

  static String generateFormula(List<int> remainders, int base) {

    if (remainders.length > 200) {
      return "Rovnice je příliš dlouhá";
    }

    String r = "";
    List<String> alphabet = Alphabet.generateFull(remainders.length).reversed.toList();

    remainders.reversed.toList().asMap().forEach((key, value) {
      r +=
          // "$value ${alphabet[key]}*$base${Alphabet.toSuperscript(Number.decimalToBase(remainders.length - key - 1, base))}";
          "$value ${alphabet[key]}*$base${Alphabet.toSuperscript((remainders.length - key - 1).toString())}";

      if (key < remainders.length - 1) {
        r += " + ";
      }
    });

    return r;
  }
}
