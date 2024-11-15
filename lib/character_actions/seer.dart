import 'package:werwolfapp/game/character_action.dart';

class SeerAction extends CharacterAction {
  SeerAction(character) : super(character, 'seer');

  @override
  void onNightAction() {
    final characters = getAliveCharacters();
    final target = selectCharacter(characters, "Rolle sehen");
    showMessage("", "You have selected ${target.role.name}");
  }
}
