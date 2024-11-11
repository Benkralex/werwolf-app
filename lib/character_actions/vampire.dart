import 'package:werwolfapp/game/character_action.dart';

class VampireAction extends CharacterAction {
  VampireAction(character) : super(character, 'vampire');

  @override
  void onNightAction() {
    final characters = getAliveCharacters();
    final target = selectCharacter(characters);
    killCharacter(target, true);
  }
}
