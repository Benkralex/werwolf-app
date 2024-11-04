import 'package:werwolfapp/game/win_group.dart';

class Role {
  int _id;
  String name;
  String desc;
  int priority;
  bool wakeUpTogether;
  Map<String, dynamic> properties = {};
  WinGroup winGroup;
  Map<String, dynamic>? onDeathAction;
  Map<String, dynamic>? onNightAction;

  Role(
      {required int id,
      required this.name,
      required this.desc,
      required this.priority,
      required this.wakeUpTogether,
      required this.properties,
      required this.winGroup,
      this.onDeathAction,
      this.onNightAction})
      : _id = id;

  factory Role.fromJSON(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      priority: json['priority'] ?? 0,
      wakeUpTogether: json['wake-up-together'] ?? false,
      properties: json['properties'] ?? {},
      winGroup: WinGroup.getWinGroup(json['win-group']),
      onDeathAction: json['on-death-action'],
      onNightAction: json['on-night-action'],
    );
  }

  int get id => _id;

  Map<String, dynamic> toJSON() {
    return {
      'id': _id,
      'name': name,
      'desc': desc,
      'priority': priority,
      'wake-up-together': wakeUpTogether,
      'properties': properties,
      'win-group': winGroup,
      'on-death-action': onDeathAction,
      'on-night-action': onNightAction,
    };
  }
}
