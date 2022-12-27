class NetworkGraphModel {
  late final Map<String, String> networkMap;

  NetworkGraphModel(List<int> remainders) {
    networkMap = generateMap(remainders);
  }

  void generate(List<int> list){
    networkMap = generateMap(list);
  }

  static generateMap(List<int> list) {
    Map<String, String> map = {};

    for (var i = 1; i < list.length; i++) {
      map.putIfAbsent(list[i - 1].toString(), () => list[i].toString());
    }
    return map;
  }
}