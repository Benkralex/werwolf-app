// ignore_for_file: avoid_print

import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/game.dart';
import 'package:werwolfapp/game/role.dart';

class GameAction {
  static List<Role> roles = [];
  static Role? activeRole;
  static int roleCounter = 0;
  static int maxRoleCounter = 0;

  static List<Character> characters = [];
  static Character? activeCharacter;
  static int characterCounter = 0;
  static int maxCharacterCounter = 0;

  static List<List<dynamic>> actions = [];

  static bool nextUpdatesDay = false;

  static void updateVariables(int roleC, int characterC) {
    print('Updating variables with roleC=$roleC, characterC=$characterC');
    //roles
    roles =
        Game.instance.getAliveRoles().where((r) => r.priority != 0).toList();
    print('Retrieved alive roles: ${roles.map((r) => r.name).toList()}');
    roles.sort((a, b) => a.name.compareTo(b.name));
    roles.sort((a, b) => a.priority.compareTo(b.priority));
    print('Sorted roles by name and priority');
    maxRoleCounter = roles.length - 1;
    roleCounter = roleC;
    if (roleCounter <= maxRoleCounter) {
      activeRole = roles[roleCounter];
      print('Set activeRole to: ${activeRole!.name}');
    } else {
      throw Exception('RoleCounter out of bounds');
    }
    //characters
    characters = Game.instance
        .getAliveCharacters()
        .where((c) => c.role == activeRole)
        .toList();
    print(
        'Filtered characters for activeRole: ${characters.map((c) => c.role.name).toList()}');
    if (activeRole!.wakeUpTogether) {
      maxCharacterCounter = 0;
      print('Active role wakes up together, set maxCharacterCounter to 0');
    } else {
      maxCharacterCounter = characters.length - 1;
      print('Set maxCharacterCounter to: $maxCharacterCounter');
    }
    characterCounter = characterC;
    if (characterCounter <= maxCharacterCounter) {
      activeCharacter = characters[characterCounter];
      print('Set activeCharacter to: ${activeCharacter!.role.name}');
    } else {
      throw Exception('CharacterCounter out of bounds');
    }
  }

  static void next() {
    print('Next action called');
    /* if (roleCounter > maxRoleCounter &&
        characterCounter > maxCharacterCounter) {
      print('Setting day mode');
      roleCounter = 0;
      characterCounter = 0;
      Game.instance.setDay(); 
    } else {*/
    actions.add([roleCounter, characterCounter]);
    updateVariables(roleCounter, characterCounter);
    if (roleCounter == 0 && characterCounter == 0) {
      if (characterCounter < maxCharacterCounter) {
        characterCounter++;
        print('Incremented characterCounter: $characterCounter');
      } else {
        if (roleCounter < maxRoleCounter) {
          roleCounter++;
          characterCounter = 0;
          print(
            'Incremented roleCounter: $roleCounter, reset characterCounter',
          );
        }
      }
      return;
    }
    if (characterCounter < maxCharacterCounter) {
      characterCounter++;
      print('Incremented characterCounter: $characterCounter');
    } else {
      if (roleCounter < maxRoleCounter) {
        roleCounter++;
        characterCounter = 0;
        print(
          'Incremented roleCounter: $roleCounter, reset characterCounter',
        );
      } else {
        if (nextUpdatesDay) {
          print('Setting day mode');
          roleCounter = 0;
          characterCounter = 0;
          nextUpdatesDay = false;
          Game.instance.setDay();
        } else {
          nextUpdatesDay = true;
        }
      }
    }
    print(
      'Updated variables and added action: roleCounter=$roleCounter, characterCounter=$characterCounter',
    );
    //}
  }

  static void previous() {
    if (actions.isNotEmpty) {
      actions.removeLast();
      if (actions.isNotEmpty) {
        roleCounter = actions.last[0];
        characterCounter = actions.last[1];
        updateVariables(roleCounter, characterCounter);
      }
    }
  }
}
