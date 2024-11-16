import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/character_action.dart';

class BodyguardAction extends CharacterAction {
  BodyguardAction(character) : super(character, 'bodyguard');

  @override
  void onNightAction() {
    final characters = getAliveCharacters();
    final target = selectCharacter(characters, "Geschützte");
    changeProperty(
      "protected-player",
      target.id,
    );
  }

  @override
  void onCharacterKill(Character character) {
    if (getProperty("protected-player") == character.id) {
      cancelKillCharacter(character);
    }
  }
}
