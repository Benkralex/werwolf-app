import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/role.dart';

class Game {
  static final Game instance = Game();

  int playerCount = 0;
  List<Character> characters = [];
  bool night = true;
  Role? activeRole;
  List<Role> rolesByPriority = [];
  List<Character> activeCharacters = [];
  Character? activeCharacter;
  int roleCounter = 0;
  int characterCounter = 0;
  bool gameOver = false;

  Game();

  void toggleNight() {
    if (isGameOver()) return;
    night ? setDay() : setNight();
  }

  void setNight() {
    if (isGameOver()) return;
    night = true;
    activeRole = null;
    next();
  }

  void setDay() {
    night = false;
    isGameOver();
    activeRole = null;
  }

  void configAllCharacters(Role role, String property, dynamic value) {
    for (final c in characters) {
      if (c.role.id == role.id) {
        c.setProperty(property, value);
      }
    }
  }

  List<Role> listUsedRoles() {
    final roles = <Role>[];
    for (final c in characters) {
      if (!roles.contains(c.role)) {
        roles.add(c.role);
      }
    }
    return roles;
  }

  Map<String, dynamic> getProperties(Role role) {
    for (final c in characters) {
      if (c.role.id == role.id) {
        return c.role.properties;
      }
    }
    return role.properties;
  }

  Character? getCharacter(int id) {
    for (final c in characters) {
      if (c.id == id) {
        return c;
      }
    }
    return null;
  }

  List<Character> getAliveCharacters() {
    return characters.where((c) => c.alive).toList();
  }

  List<Role> getAliveRoles() {
    final roles = <Role>[];
    for (final c in characters) {
      if (c.alive && !roles.contains(c.role)) {
        roles.add(c.role);
      }
    }
    return roles;
  }

  List<Character> getCharactersByPriority(int priority) {
    return characters.where((c) => c.role.priority == priority).toList();
  }

  void next() {
    if (isGameOver()) return;
    rolesByPriority = getAliveRoles()
      ..sort((a, b) {
        final priorityComparison = a.priority.compareTo(b.priority);
        return priorityComparison != 0
            ? priorityComparison
            : a.id.compareTo(b.id);
      });
    rolesByPriority.removeWhere((r) => r.priority == 0);
    if (!night) activeRole = null;
    if (night) {
      if (activeRole == null) {
        roleCounter = 0;
        characterCounter = 0;
        activeRole = rolesByPriority[roleCounter];
        activeCharacters = getCharactersByPriority(activeRole!.priority);
        activeCharacters.removeWhere((c) => !c.alive);
        activeCharacter = activeCharacters[characterCounter];
      } else if ((activeCharacters.length <= characterCounter + 1) ||
          (activeRole!.wakeUpTogether)) {
        characterCounter = 0;
        roleCounter++;
        if (rolesByPriority.length <= roleCounter) {
          setDay();
        } else {
          activeRole = rolesByPriority[roleCounter];
          activeCharacters = getCharactersByPriority(activeRole!.priority);
          activeCharacters.removeWhere((c) => !c.alive);
          activeCharacter = activeCharacters[characterCounter];
        }
      } else {
        characterCounter++;
        activeCharacter = activeCharacters[characterCounter];
      }
    }
  }

  void previous() {
    if (isGameOver()) return;
    if (night) {
      if (activeRole == null) {
        roleCounter = rolesByPriority.length - 1;
        characterCounter =
            getCharactersByPriority(rolesByPriority[roleCounter].priority)
                    .length -
                1;
        activeRole = rolesByPriority[roleCounter];
        activeCharacters = getCharactersByPriority(activeRole!.priority);
        activeCharacters.removeWhere((c) => !c.alive);
        activeCharacter = activeCharacters[characterCounter];
      } else if (characterCounter == 0) {
        roleCounter--;
        if (roleCounter < 0) {
          activeRole = null;
        } else {
          activeRole = rolesByPriority[roleCounter];
          activeCharacters = getCharactersByPriority(activeRole!.priority);
          activeCharacters.removeWhere((c) => !c.alive);
          characterCounter = activeCharacters.length - 1;
          activeCharacter = activeCharacters[characterCounter];
        }
      } else {
        characterCounter--;
        activeCharacter = activeCharacters[characterCounter];
      }
    }
  }

  bool isGameOver() {
    if (getAliveRoles().length <= 1) {
      gameOver = true;
    }
    return gameOver;
  }
}
