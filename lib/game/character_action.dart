import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/game.dart';

abstract class CharacterAction {
  Character character;
  String actionName;

  CharacterAction(
    this.character,
    this.actionName,
  );

  List<Character> getAliveCharacters() {
    return Game.instance.getAliveCharacters();
  }

  List<Character> getKillAtEndOfDayCharacters() {
    return Game.instance.killAtEndOfDay;
  }

  List<Character> getKillAtStartOfDayCharacters() {
    return Game.instance.killAtStartOfDay;
  }

  Character selectCharacter(List<Character> characters, String title) {
    return Game.instance.selectCharacter!(characters, title);
  }

  void killCharacter(Character character, bool endOfDay,
      {bool instant = false}) {
    if (instant) {
      character.kill();
      return;
    }
    if (endOfDay) {
      Game.instance.killAtEndOfDay.add(
        Game.instance.characters.where((c) => c.id == character.id).first,
      );
    } else {
      Game.instance.killAtStartOfDay.add(
        Game.instance.characters.where((c) => c.id == character.id).first,
      );
    }
  }

  String selectOf(String title, String action1, String action2) {
    return Game.instance.selectOf!(title, action1, action2);
  }

  void cancelKillCharacter(Character character) {
    Game.instance.killAtEndOfDay.removeWhere((c) => c.id == character.id);
    Game.instance.killAtStartOfDay.removeWhere((c) => c.id == character.id);
  }

  void changeProperty(String property, dynamic value) {
    character.setProperty(property, value);
  }

  dynamic getProperty(String property) {
    return character.getProperty(property);
  }

  void showMessage(String title, String message) {
    Game.instance.showMessage!(title, message);
  }

  void onNightAction() {}

  void onDeathAction() {}

  void onCharacterKill(Character character) {}
}
