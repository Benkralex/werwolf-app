import 'package:werwolfapp/game/action.dart';
import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/role.dart';

class Game {
  static final Game instance = Game();

  List<Character> killAtEndOfDay = [];
  List<Character> killAtStartOfDay = [];
  int playerCount = 0;
  List<Character> characters = [];
  bool night = true;
  Role? activeRole;
  List<Role> rolesByPriority = [];
  bool gameOver = false;

  Game();

  void toggleNight() {
    if (isGameOver()) return;
    night ? setDay() : setNight();
  }

  void setNight() {
    gameOver = gameOver || hasWon();
    if (isGameOver()) return;
    for (final c in killAtEndOfDay) {
      c.kill();
    }
    night = true;
    activeRole = null;
    next();
  }

  void setDay() {
    gameOver = gameOver || hasWon();
    if (isGameOver()) return;
    for (final c in killAtStartOfDay) {
      c.kill();
    }
    night = false;
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
    GameAction.next();
    activeRole = GameAction.activeRole;
    final activeCharacter = GameAction.activeCharacter;
    if (activeCharacter != null) {
      activeCharacter.onNightAction();
    } else {
      characters
          .where(
            (c) => (c.role == activeRole) && c.role.wakeUpTogether,
          )
          .first
          .onNightAction();
    }
  }

  void previous() {
    if (isGameOver()) return;
    GameAction.previous();
    activeRole = GameAction.activeRole;
  }

  bool isGameOver() {
    gameOver = (getAliveRoles().length <= 1);
    // ignore: avoid_print
    if (gameOver) print("Game Over");
    return gameOver;
  }

  bool hasWon() {
    for (final c in characters) {
      if (c.hasWon()) {
        // ignore: avoid_print
        print('${c.role.name} (${c.playerName}) has won');
        gameOver = true;
      }
    }
    return gameOver;
  }
}
