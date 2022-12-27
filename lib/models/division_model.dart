import 'dart:math';

import 'package:divisibility_calculator/utils/alphabet.dart';
import 'package:divisibility_calculator/utils/number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class DivisionModel {
  /// Soustava
  final int system;

  /// Dělitel
  final int divider;

  /// Dělitel ve zvolené soustavě
  late final String dividerInBase;

  /// Zbytky
  List<int> remainders = [];

  late final List<String> calculations;

  DivisionModel({required this.system, required this.divider}) {
    dividerInBase =
        "(${Number.decimalToBase(divider, system)}${Alphabet.toSubscript(system.toString())})";
    process(system, divider);
  }

  DivisionModel copyWith({int? system, int? divider}) {
    return DivisionModel(
      system: system ?? this.system,
      divider: divider ?? this.divider,
    );
  }

  List<int> generateRemainders(int divider, int system) {
    List<int> remainders = [];
    int remainder = 1;

    for (var i = 0; i < divider; i++) {
      remainders.add(remainder);
      if (remainder == 0) {
        break;
      }
      remainder = (remainder * system).remainder(divider);
      if (remainders.contains(remainder)) {
        remainders.add(remainder);
        break;
      }
    }
    return remainders;
  }

  void process(int system, int divider) {
    if (divider < 2 || system < 2) {
      remainders = [];
      calculations = ['Systém či dělitel je příliš malý'];
      return;
    }

    remainders = generateRemainders(divider, system);

    List<String> alphabet = Alphabet.generate(divider, remainders.length);

    List<String> lines = [];

    lines.add(
        "${pow(system, 0)} ${alphabet[0]} =>${remainders[0]} ${alphabet[0]}");
    for (int i = 1; i < remainders.length; i++) {
      lines.add(
          "${remainders[i - 1] * system}${Alphabet.toSubscript("10")} ${alphabet[i]} => ${remainders[i]}${Alphabet.toSubscript("10")} ${alphabet[i]}");

      if (remainders[i] == 0) {
        lines.add(_tailZero(divider, i));
        break;
      }
    }

    calculations = lines;
  }

  String _tailZero(int divider, int index) {
    var lastText = index < 5 ? "poslední" : "posledních";
    var position = index == 1
        ? "cifra dělitelná"
        : index < 5
            ? "cifry dělitelné"
            : "cifer dělitelných";
    return "Aby bylo číslo dělitelné $divider, musí být $lastText  $index $position $divider";
  }
}

class DivisionModelNotifier extends StateNotifier<DivisionModel> {
  DivisionModelNotifier(int system, int divider)
      : super(DivisionModel(system: system, divider: divider));

  void setDivider(int divider) {
    state = state.copyWith(divider: divider);
  }

  void setSystem(int system) {
    state = state.copyWith(system: system);
  }
}
