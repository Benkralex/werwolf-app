class WinCondition {
  final int id;
  final String name;
  final String winCondition;
  final String winConditionString;
  final String type;

  WinCondition(
      {required this.id,
      required this.name,
      required this.winCondition,
      required this.winConditionString,
      required this.type});

  factory WinCondition.fromJson(Map<String, dynamic> json) {
    return WinCondition(
        id: json['id'],
        name: json['name'],
        winCondition: json['win-condition'],
        winConditionString: json['win-condition-string'],
        type: json['type']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'win-condition': winCondition,
      'win-condition-string': winConditionString,
      'type': type
    };
  }

  bool isIndividual() {
    return type == 'individual';
  }

  bool isGroup() {
    return type == 'group';
  }
}
