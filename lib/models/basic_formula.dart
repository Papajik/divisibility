import 'package:divisibility_calculator/utils/alphabet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class BasicFormulaModel extends StateNotifier<String> {
  BasicFormulaModel(int length) : super(generateFormula(length));


  void generate(int length){
    state = generateFormula(length);
  }


  static String generateFormula(int length) {
    List<String> alphabet = Alphabet.generateFull(length);

    String r = "";
    for (var a in alphabet){

    }

    return r;
  }
}