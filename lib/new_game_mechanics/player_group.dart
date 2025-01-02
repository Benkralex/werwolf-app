import 'package:werwolfapp/new_game_mechanics/Player.dart';

class PlayerGroup {
  final int id;
  final List<Player> players;

  PlayerGroup(this.id, this.players);

  void addPlayer(Player player) {
    players.add(player);
  }

  void removePlayer(Player player) {
    players.remove(player);
  }
}
