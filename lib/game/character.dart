import 'package:werwolfapp/game/character_action.dart';
import 'package:werwolfapp/game/character_action_repository.dart';
import 'package:werwolfapp/game/game.dart';
import 'package:werwolfapp/game/role.dart';

class Character {
  static int _highestId = 0;
  final Role _role;
  final int id;
  String? notes;
  String? playerName;
  bool alive = true;
  Map<String, dynamic> properties;
  CharacterAction? action;

  Character({required Role role})
      : _role = role,
        properties = Map<String, dynamic>.from(role.properties),
        id = ++_highestId;

  Role get role => _role;

  void onNightAction() {
    if (action != null) {
      action!.onNightAction();
    } else {
      if (role.onNightAction != null) {
        action = CharacterActionRepository.action(this);
        action!.onNightAction();
      }
    }
  }

  void onDeathAction() {
    if (action != null) {
      action!.onDeathAction();
    } else {
      if (role.onDeathAction != null) {
        action = CharacterActionRepository.action(this);
        action!.onDeathAction();
      }
    }
  }

  void setNotes(String notes) {
    this.notes = notes;
  }

  void setPlayerName(String playerName) {
    this.playerName = playerName;
  }

  void kill() {
    onDeathAction();
    alive = false;
  }

  void revive() {
    alive = true;
  }

  bool hasWon() {
    List<Character> playersNotInGroup = Game.instance
        .getAliveCharacters()
        .where((c) => !(c.role.winCondition.id == role.winCondition.id))
        .toList();
    List<Character> playersInGroup = Game.instance
        .getAliveCharacters()
        .where((c) => (c.role.winCondition.id == role.winCondition.id))
        .toList();
    switch (role.winCondition.winCondition) {
      case 'kill-all-enemies':
        return playersNotInGroup.isEmpty;
      case 'be-half-of-all-players':
        if (playersInGroup.isEmpty) {
          return false;
        }
        return playersInGroup.length >= playersNotInGroup.length;
      case 'get-killed':
        return !alive;
      case 'survive':
        return Game.instance.isGameOver() && alive;
      default:
        // ignore: avoid_print
        print(
            "Error: Unknown win condition: ${role.winCondition.winCondition}");
        return false;
    }
  }

  Map<String, dynamic> getProperties() {
    return properties;
  }

  dynamic getProperty(String property) {
    return properties[property];
  }

  void setProperty(String property, dynamic value) {
    properties[property] = value;
  }

  void resetProperties() {
    properties = Map<String, dynamic>.from(_role.properties);
  }
}
