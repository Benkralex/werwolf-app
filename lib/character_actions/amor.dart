import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/character_action.dart';

class AmorAction extends CharacterAction {
  AmorAction(character) : super(character, 'amor');

  @override
  void onNightAction() {
    final characters = getAliveCharacters();
    final target1 = selectCharacter(
      characters,
      "Partner 1",
    );
    final target2 = selectCharacter(
      characters.where((c) => c.id != target1.id).toList(),
      "Partner 2",
    );
    changeProperty(
      "lovers",
      getProperty("lovers").append(
        [target1.id, target2.id],
      ),
    );
  }

  @override
  void onCharacterKill(Character character) {
    final lovers = getProperty("lovers");
    final characters = getAliveCharacters();
    for (final lover in lovers) {
      if (lover.contains(character.id)) {
        killCharacter(
          characters.where((c) => lover.contains(c.id)).first,
          false,
          instant: true,
        );
      }
    }
  }
}
