import 'dart:math';

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
}
