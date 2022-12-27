import 'package:divisibility_calculator/utils/alphabet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasicFormulaModel extends StateNotifier<String> {
  BasicFormulaModel(int length, int base)
      : super(generateFormula(length, base));

  void generate(int length, int base) {
    state = generateFormula(length, base);
  }

  String get formula => state;

  static String generateFormula(int length, int base) {
    if (length > 200) {
      return "Rovnice je příliš dlouhá";
    }

    List<String> alphabet = Alphabet.generateFull(length);

    String r = "";
    alphabet.reversed.toList().asMap().forEach((key, value) {
      r +=
          // "$value*$base${Alphabet.toSuperscript(Number.decimalToBase(alphabet.length - key - 1, base))}";
          "$value*$base${Alphabet.toSuperscript((alphabet.length - key - 1).toString())}";
      if (key < alphabet.length - 1) {
        r += " + ";
      }
    });

    return r;
  }
}
