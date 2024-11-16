import 'package:werwolfapp/character_actions/amor.dart';
import 'package:werwolfapp/character_actions/bodyguard.dart';
import 'package:werwolfapp/character_actions/hunter.dart';
import 'package:werwolfapp/character_actions/priest.dart';
import 'package:werwolfapp/character_actions/seer.dart';
import 'package:werwolfapp/character_actions/vampire.dart';
import 'package:werwolfapp/character_actions/werewolf.dart';
import 'package:werwolfapp/character_actions/witch.dart';
import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/character_action.dart';

class CharacterActionRepository {
  static final Map<Character, CharacterAction> actions = {};

  static CharacterAction action(Character character) {
    late final String actionType;
    if (!(character.role.onNightAction == null ||
        character.role.onNightAction == '')) {
      actionType = character.role.onNightAction!;
    } else if (!(character.role.onDeathAction == null ||
        character.role.onDeathAction == '')) {
      actionType = character.role.onDeathAction!;
    } else {
      throw Exception('No action defined for character ${character.role.name}');
    }
    if (actions.containsKey(character)) {
      return actions[character]!;
    }
    switch (actionType) {
      case 'amor':
        actions[character] = AmorAction(character);
        return actions[character]!;
      case 'bodyguard':
        actions[character] = BodyguardAction(character);
        return actions[character]!;
      case 'hunter':
        actions[character] = HunterAction(character);
        return actions[character]!;
      case 'priest':
        actions[character] = PriestAction(character);
        return actions[character]!;
      case 'seer':
        actions[character] = SeerAction(character);
        return actions[character]!;
      case 'vampire':
        actions[character] = VampireAction(character);
        return actions[character]!;
      case 'werewolf':
        actions[character] = WerewolfAction(character);
        return actions[character]!;
      case 'witch':
        actions[character] = WitchAction(character);
        return actions[character]!;
      default:
        throw Exception('Unknown action type: $actionType');
    }
  }

  static void onDeath(Character character) {
    action(character).onDeathAction();
  }

  static void onNight(Character character) {
    action(character).onNightAction();
  }
}
