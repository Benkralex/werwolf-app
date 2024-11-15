import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/character_action.dart';

class PriestAction extends CharacterAction {
  PriestAction(character) : super(character, 'priest');

  @override
  void onNightAction() {
    final characters = getAliveCharacters();
    final target = selectCharacter(characters, "Schütze");
    changeProperty(
      "protected-players",
      getProperty("protected-players").add(target.id),
    );
  }

  @override
  void onCharacterKill(Character character) {
    if (getProperty("protected-players").contains(character.id)) {
      cancelKillCharacter(character);
    }
  }
}
