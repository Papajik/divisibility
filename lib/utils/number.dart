import 'dart:math';

import 'package:flutter/material.dart';

class Number {
  static String decimalToBase(int number, int base) {
    String n = "";
    int rest = number;
    int alphabetStart = 65 - 10;

    if (rest <= 1 || base <= 1) {
      return number.toString();
    }
    while (rest != 0) {
      int d = rest % base;
      if (d >= 10) {
        n = String.fromCharCode(alphabetStart + d) + n;
      } else {
        n = d.toString() + n;
      }
      rest = (rest / base).floor();
    }
    return n;
  }

  static String baseToDecimal(String number, int originalSystem) {


    List<String> numList = number.characters
        .toList()
        .reversed
        .toList();


    int n = 0;

    for (var i = 0; i < numList.length; i++) {
      n += (int.tryParse(numList[i]) ?? parseNumber(numList[i])) * pow(originalSystem, i).toInt();

    }
    return n.toString();
  }

  static int parseNumber(String e) {
    int codeUnit = e.codeUnitAt(0);
    int big = 65 - 10;
    int small = 97 - 10;
    int value = -1;
    if (codeUnit > 90) {
      /// Malé písmeno
      value = codeUnit - small;
    } else {
      /// Velké písmeno
      value = codeUnit - big;
    }
    return value;
  }
}
