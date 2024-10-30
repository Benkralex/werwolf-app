import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/role.dart';

class Game {
  static Game game = Game();

  int playerCount = 0;
  List<Character> characters = [];
  bool night = true;
  Character? activeCharacter;
  List<Character> charactersByPriority = [];
  int counter = 0;

  Game();

  void toggleNight() {
    night ? setDay() : setNight();
  }

  void setNight() {
    night = true;
    activeCharacter = null;
    next();
  }

  void setDay() {
    night = false;
    activeCharacter = null;
  }

  void addCharacter(Character character) {
    characters.add(character);
  }

  void removeCharacter(Character character) {
    characters.remove(character);
  }

  void configAllCharacters(Role role, String property, dynamic value) {
    for (final c in game.characters) {
      if (c.role.id == role.id) {
        c.setProperty(property, value);
      }
    }
  }

  List<Role> listUsedRoles() {
    List<Role> roles = [];
    for (final c in game.characters) {
      if (!roles.contains(c.role)) {
        roles.add(c.role);
      }
    }
    return roles;
  }

  Map<String, dynamic> getProperties(Role role) {
    Map<String, dynamic> properties = role.properties;
    for (final c in characters) {
      if (c.role.id == role.id) {
        properties = c.role.properties;
      }
    }
    return properties;
  }

  Character? getCharacter(int id) {
    for (final c in game.characters) {
      if (c.id == id) {
        return c;
      }
    }
    return null;
  }

  List<Character> getAliveCharacters() {
    List<Character> aliveCharacters = [];
    for (final c in game.characters) {
      if (c.alive) {
        aliveCharacters.add(c);
      }
    }
    return aliveCharacters;
  }

  List<Character> getCharactersByPriority(int priority) {
    List<Character> charactersByPriority = [];
    for (final c in game.characters) {
      if (c.role.priority == priority) {
        charactersByPriority.add(c);
      }
    }
    return charactersByPriority;
  }

  void next() {
    charactersByPriority = List<Character>.from(getAliveCharacters());
    charactersByPriority.sort((a, b) => a.role.id.compareTo(b.role.id));
    charactersByPriority
        .sort((a, b) => a.role.priority.compareTo(b.role.priority));
    if (!night) activeCharacter = null;
    counter++;
    if (counter >= charactersByPriority.length) {
      setDay();
      activeCharacter = null;
    }
    activeCharacter = charactersByPriority[counter];
  }

  void previous() {
    if (counter > 0) {
      counter--;
      activeCharacter = charactersByPriority[counter];
    }
  }
}
