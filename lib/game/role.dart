class Role {
  int _id;
  String name;
  String desc;
  int priority;
  Map<String, dynamic> properties = {};

  Role(
      {required int id,
      required this.name,
      required this.desc,
      required this.priority,
      required this.properties})
      : _id = id;

  factory Role.fromJSON(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      priority: json['priority'],
      properties: json['properties'],
    );
  }

  int get id => _id;

  Map<String, dynamic> toJSON() {
    return {
      'id': _id,
      'name': name,
      'desc': desc,
      'priority': priority,
      'properties': properties
    };
  }
}
