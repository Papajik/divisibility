import 'package:divisibility_calculator/utils/number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationModel extends StateNotifier<List<String>> {
  VerificationModel(
      List<int> remainders, String number, int divider, int system)
      : super(verifyResult(remainders, number, divider, system));

  void verify(List<int> remainders, String number, int divider, int system) {
    state = verifyResult(remainders, number, divider, system);
  }

  bool get hasResult => state.length >= 2;

  static List<String> verifyResult(
      List<int> remainders, String number, int divider, int system) {
    /// Pokud končí list 0, řeším jen předcházející cifry
    /// Pokud je číslo delší než velikost pole, prodloužím pole

    if (remainders.isEmpty) {
      return ["Neplatný výsledek"];
    }


    if (remainders.last == 0) {
      remainders.removeLast();
    } else {
      /// 1. najdi subArray
      /// 2. prodluž array

      while (remainders.length < number.characters.length) {
        var index =
            remainders.lastIndexWhere((element) => element == remainders.first);
        var sublist = remainders.sublist(0, index);
        remainders = [...sublist, ...remainders];
      }
    }

    List<int> numList = number.characters
        .toList()
        .reversed
        .map((e) => int.tryParse(e) ?? Number.parseNumber(e))
        .toList();
    if (numList.any(
      (element) => element >= system,
    )) {
      return ["Neplatné číslo"];
    }

    remainders = remainders.reversed.toList();
    int sum = 0;
    var result = "";
    for (var i = 0; i < numList.length; i++) {
      result += "${numList[i]}*${remainders[i]}";
      sum += remainders[i] * numList[i];
      if (numList.length > i + 1) {
        result += " + ";
      }
    }

    return [
      "$result = $sum",
      "$sum % $divider = ${sum % divider}",
      sum % divider == 0 ? "Číslo je dělitelné" : "Číslo není dělitelné"
    ];
  }
}
