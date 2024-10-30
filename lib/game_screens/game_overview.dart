import 'package:flutter/material.dart';
import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/game.dart';
import 'package:werwolfapp/game/role.dart';
import 'package:werwolfapp/game_screens/day.dart';
import 'package:werwolfapp/game_screens/night.dart';
import 'package:werwolfapp/game_screens/player_overview.dart';
import 'package:werwolfapp/main.dart';

class GameOverviewScreen extends StatefulWidget {
  const GameOverviewScreen({super.key});

  @override
  State<GameOverviewScreen> createState() => _GameOverviewScreenState();
}

class _GameOverviewScreenState extends State<GameOverviewScreen> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Übersicht'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Game.game.toggleNight();
              });
            },
            icon: (Game.game.night)
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode),
            color: menuIconsColor,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const PlayerOverviewScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              ).then((_) {
                setState(() {});
              });
            },
            icon: const Icon(Icons.group),
            color: menuIconsColor,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  Game.game.night ? 'Nacht' : 'Tag',
                  style: const TextStyle(fontSize: 30),
                ),
                Text(
                  Game.game.night
                      ? (Game.game.activeCharacter ??
                              Character(
                                  role: Role(
                                      id: -11,
                                      name: "Error",
                                      desc: "Error",
                                      priority: 0,
                                      properties: {})))
                          .role
                          .name
                      : 'Lasse das Dorf einen Spieler lynchen',
                )
              ],
            ),
          ),
          if (!Game.game.night)
            Expanded(child: DayWidget(update: update))
          else
            Expanded(child: NightWidget(update: update)),
        ],
      ),
    );
  }
}
