import 'package:flutter/material.dart';
import 'package:werwolfapp/game/game.dart';
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
                Game.instance.toggleNight();
              });
            },
            icon: (Game.instance.night)
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
                  Game.instance.night ? 'Nacht' : 'Tag',
                  style: const TextStyle(fontSize: 30),
                ),
                Text(
                  Game.instance.night
                      ? Game.instance.activeRole!.name
                      : 'Lasse das Dorf einen Spieler lynchen',
                )
              ],
            ),
          ),
          if (!Game.instance.night)
            Expanded(child: DayWidget(update: update))
          else
            Expanded(child: NightWidget(update: update)),
        ],
      ),
    );
  }
}
