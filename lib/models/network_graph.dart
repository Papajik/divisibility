import 'package:flutter_riverpod/flutter_riverpod.dart';


class NetworkGraphModel extends StateNotifier<Map<String, String>> {
  NetworkGraphModel(List<int> remainders) : super(generateMap(remainders));

  void generate(List<int> list){
    state = generateMap(list);
  }

  static generateMap(List<int> list) {
    Map<String, String> map = {};

    for (var i = 1; i < list.length; i++) {
      map.putIfAbsent(list[i - 1].toString(), () => list[i].toString());
    }
    return map;
  }
}