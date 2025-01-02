import 'package:werwolfapp/new_game_mechanics/Player.dart';
import 'package:werwolfapp/new_game_mechanics/player_group.dart';

class Game {
  List<Player> stagedEndOfDayKills = [];
  List<Player> stagedStartOfDayKills = [];
  List<PlayerGroup> playerGroups = [];
  List<List<dynamic>> killedPlayers = []; // [Player, PlayerGroup]
  bool night = true;

  Function? showMessage;
  Function? selectPlayer;
  Function? selectOf;

  //Priority:
  // 0: Dosn't wake up (Villager, etc.)
  // 1: Wake up before Werewolves (Seer, etc.)
  // 2: Wake up with Werewolves (Werewolves, Vampire, etc.)
  // 3: Wake up after Werewolves (Witch, etc.)
  int activePriority = 0;
  int activeGroup = 0;

  PlayerGroup? getPlayerGroupOf(Player targetPlayer) {
    for (final group in playerGroups) {
      if (group.players.contains(targetPlayer)) {
        return group;
      }
    }
    return null;
  }

  //Kill handeling
  void stageEndOfDayKill(Player player) {
    stagedEndOfDayKills.add(player);
  }

  void stageStartOfDayKill(Player player) {
    stagedStartOfDayKills.add(player);
  }

  void killPlayer(Player player) {
    player.alive = false;
    final group = getPlayerGroupOf(player);
    killedPlayers.add([player, group]);
    if (group != null) {
      group.removePlayer(player);
    }
  }

  //Day/Night handeling
  void setNight() {
    for (final player in stagedEndOfDayKills) {
      killPlayer(player);
    }
    night = true;
  }

  void setDay() {
    for (final player in stagedStartOfDayKills) {
      killPlayer(player);
    }
    night = false;
  }
}
