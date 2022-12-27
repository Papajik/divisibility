import 'dart:math';

import 'package:flutter/material.dart';

class Alphabet {
  static List<String> generate(length, maxLength) {
    int start = 65;
    int end = 90;
    int loop = end - start;
    List<String> alphabet = [];
    for (int x = 0; x <= min(length - 1, maxLength); x++) {
      int index = x;
      List<int> charCodes = [];
      while (index >= 0) {
        if (index > loop) {
          charCodes.add(start);
        } else {
          charCodes.add(start + index);
        }
        index -= loop;
      }
      alphabet.add(String.fromCharCodes(charCodes));
    }
    return alphabet;
    //return alphabet.reversed.toList();
  }

  static List<String> generateFull(length) {
    int start = 65;
    int end = 90;
    int loop = end - start;
    List<String> alphabet = [];
    for (int x = 0; x < length; x++) {
      int index = x;
      List<int> charCodes = [];
      while (index >= 0) {
        if (index > loop) {
          charCodes.add(start);
        } else {
          charCodes.add(start + index);
        }
        index -= loop;
      }
      alphabet.add(String.fromCharCodes(charCodes));
    }
    return alphabet;
  }

  static String toSuperscript(String number) {
    String s = "";

    for (var element in number.characters) {
      s += superscripts[int.parse(element)];
    }
    return s;
  }

  static String toSubscript(String number) {
    String s = "";

    for (var element in number.characters) {
      s += subscripts[int.parse(element)];
    }
    return s;
  }

  static final superscripts = [
    '\u2070',
    '\u00B9',
    '\u00B2',
    '\u00B3',
    '⁴',
    '⁵',
    '⁶',
    '⁷',
    '⁸',
    '⁹',
  ];


  static final subscripts = [
    '₀',
    '₁',
    '₂',
    '₃',
    '₄',
    '₅',
    '₆',
    '₇',
    '₈',
    '₉',
  ];




}
