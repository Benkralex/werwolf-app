import 'package:werwolfapp/game/win_condition.dart';
import 'package:werwolfapp/game/win_condition_repository.dart';

class Role {
  int _id;
  String name;
  String desc;
  int priority;
  bool wakeUpTogether;
  Map<String, dynamic> properties = {};
  WinCondition winCondition;
  Map<String, dynamic>? onDeathAction;
  Map<String, dynamic>? onNightAction;
  int maxCount = 40;

  Role(
      {required int id,
      required this.name,
      required this.desc,
      required this.priority,
      required this.wakeUpTogether,
      required this.properties,
      required this.winCondition,
      this.onDeathAction,
      this.onNightAction,
      this.maxCount = 40})
      : _id = id;

  factory Role.fromJSON(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      priority: json['priority'] ?? 0,
      wakeUpTogether: json['wake-up-together'] ?? false,
      properties: json['properties'] ?? {},
      winCondition:
          WinConditionRepository.getWinCondition(json['win-condition']),
      onDeathAction: json['on-death-action'],
      onNightAction: json['on-night-action'],
      maxCount: json['max-count'] ?? 40,
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
      'win-condition': winCondition.id,
      'on-death-action': onDeathAction,
      'on-night-action': onNightAction,
      if (maxCount != 40) 'max-count': maxCount,
    };
  }
}
