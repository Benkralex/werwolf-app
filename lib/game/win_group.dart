class WinGroup {
  static List<WinGroup> winGroups = [];
  final int id;
  final String name;
  final String winCondition;
  final String winConditionString;

  WinGroup({
    required this.id,
    required this.name,
    required this.winCondition,
    required this.winConditionString,
  });

  factory WinGroup.fromJson(Map<String, dynamic> json) {
    return WinGroup(
      id: json['id'],
      name: json['name'],
      winCondition: json['win-condition'],
      winConditionString: json['win-condition-string'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'win-condition': winCondition,
      'win-condition-string': winConditionString,
    };
  }

  static WinGroup getWinGroup(int id) {
    return winGroups.firstWhere((element) => element.id == id);
  }

  static List<WinGroup> loadJsonList(
      List<Map<String, dynamic>>? mappedJsonList) {
    if (mappedJsonList == null) {
      return [];
    }
    return mappedJsonList.map((e) => WinGroup.fromJson(e)).toList();
  }
}
