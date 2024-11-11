import 'package:werwolfapp/game/character_action.dart';

class WitchAction extends CharacterAction {
  WitchAction(character) : super(character, 'witch');

  @override
  void onNightAction() {
    String actionType;
    List<String> possibleActionTypes = [];
    if (getProperty("count-healing-potions") > 0) {
      possibleActionTypes.add("heal");
    }
    if (getProperty("count-death-potions") > 0) {
      possibleActionTypes.add("kill");
    }
    if (possibleActionTypes.length == 2) {
      actionType = selectOf(possibleActionTypes[0], possibleActionTypes[1]);
    } else if (possibleActionTypes.length == 1) {
      actionType = possibleActionTypes[0];
    } else {
      return;
    }

    if (actionType == "kill") {
      final characters = getAliveCharacters();
      final target = selectCharacter(characters);
      killCharacter(target, true);
      changeProperty(
        "count-death-potions",
        getProperty("count-death-potions") - 1,
      );
    } else if (actionType == "heal") {
      final characters =
          getKillAtEndOfDayCharacters() + getKillAtStartOfDayCharacters();
      final target = selectCharacter(characters);
      cancelKillCharacter(target);
      changeProperty(
        "count-healing-potions",
        getProperty("count-healing-potions") - 1,
      );
    } else {
      throw Exception("Invalid action type");
    }
  }
}
