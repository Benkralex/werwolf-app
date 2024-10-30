import 'package:werwolfapp/game/role.dart';

class Character {
  static int _highestId = 0;
  final Role _role;
  final int id;
  String? notes;
  String? playerName;
  bool alive = true;
  Map<String, dynamic> properties;

  Character({required Role role})
      : _role = role,
        properties = Map<String, dynamic>.from(role.properties),
        id = ++_highestId;

  Role get role => _role;

  void setNotes(String notes) {
    this.notes = notes;
  }

  void setPlayerName(String playerName) {
    this.playerName = playerName;
  }

  void kill() {
    alive = false;
  }

  void revive() {
    alive = true;
  }

  Map<String, dynamic> getProperties() {
    return properties;
  }

  dynamic getProperty(String property) {
    return properties[property]; // Return the property value
  }

  void setProperty(String property, dynamic value) {
    properties[property] = value;
  }

  void resetProperties() {
    properties = Map<String, dynamic>.from(_role.properties);
  }
}
