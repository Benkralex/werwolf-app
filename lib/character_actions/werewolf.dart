import 'package:werwolfapp/game/character_action.dart';

class WerewolfAction extends CharacterAction {
  WerewolfAction(character) : super(character, 'werewolf');

  @override
  void onNightAction() {
    final characters = getAliveCharacters();
    final target = selectCharacter(characters);
    killCharacter(target, false);
  }
}
