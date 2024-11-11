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
  static CharacterAction action(String actionType, Character character) {
    switch (actionType) {
      case 'amor':
        return AmorAction(character);
      case 'bodyguard':
        return BodyguradAction(character);
      case 'hunter':
        return HunterAction(character);
      case 'priest':
        return PriestAction(character);
      case 'seer':
        return SeerAction(character);
      case 'vampire':
        return VampireAction(character);
      case 'werewolf':
        return WerewolfAction(character);
      case 'witch':
        return WitchAction(character);
      default:
        throw Exception('Unknown action type: $actionType');
    }
  }
}
