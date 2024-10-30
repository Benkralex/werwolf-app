class Role {
  static List<Role> roles = [];
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

  // Factory-Konstruktor zur Erstellung eines Role-Objekts aus JSON
  factory Role.fromJSON(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      priority: json['priority'],
      properties: json['properties'],
    );
  }

  addToRoles() {
    roles.add(this);
  }

  //Getter für id
  int get id => _id;

  // Methode zur Konvertierung in JSON
  Map<String, dynamic> toJSON() {
    return {
      'id': _id,
      'name': name,
      'desc': desc,
      'priority': priority,
      'properties': properties
    };
  }

  // Methode zur Konvertierung in JSON
  static List<Map<String, dynamic>> saveJsonList() {
    List<Map<String, dynamic>> jsonList = [];
    for (var role in roles) {
      jsonList.add(role.toJSON());
    }
    return jsonList;
  }

  // Statische Methode zur Erstellung einer Liste von Role-Objekten aus JSON
  static List<Role> loadJsonList(List<Map<String, dynamic>> jsonList) {
    List<Role> roles = [];
    for (var roleJson in jsonList) {
      roles.add(Role.fromJSON(roleJson));
    }
    return roles;
  }

  static Role getRole(int id) {
    for (final r in Role.roles) {
      if (r.id == id) {
        return r;
      }
    }
    return Role.roles[0];
  }
}
