class Role {
  final int id;
  String name;
  String desc;
  int priority;
  bool isGroup;
  Map<String, dynamic> properties = {};
  String
      winCondition; // survive, be-half-of-all-players, get-killed, kill-all-enimies
  int maxCount;

  Role(
      {required this.id,
      required this.name,
      required this.desc,
      required this.priority,
      required this.isGroup,
      required this.properties,
      required this.winCondition,
      this.maxCount = 40});

  factory Role.fromJSON(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      priority: json['priority'] ?? 0,
      isGroup: json['is-group'] ?? false,
      properties: json['properties'] ?? {},
      winCondition: json['win-condition'] ?? 'survive',
      maxCount: json['max-count'] ?? 40,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      if (priority != 0) 'priority': priority,
      if (isGroup != false) 'is-group': isGroup,
      if (properties.isNotEmpty) 'properties': properties,
      if (winCondition != 'survive') 'win-condition': winCondition,
      if (maxCount != 40) 'max-count': maxCount,
    };
  }
}
