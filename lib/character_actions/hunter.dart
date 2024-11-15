import 'package:werwolfapp/game/character_action.dart';

class HunterAction extends CharacterAction {
  HunterAction(character) : super(character, 'hunter');

  @override
  void onDeathAction() {
    final characters = getAliveCharacters();
    final target = selectCharacter(characters, "Töte");
    killCharacter(target, false, instant: true);
  }
}
