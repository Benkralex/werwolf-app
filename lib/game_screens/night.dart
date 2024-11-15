import 'package:flutter/material.dart';
import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/game.dart';

class NightWidget extends StatefulWidget {
  final Function update;
  const NightWidget({super.key, required this.update});

  @override
  State<NightWidget> createState() => NightWidgetState();
}

class NightWidgetState extends State<NightWidget> {
  void showMessage(String title, String message) {
    //Show popup-msg
  }

  Character selectCharacter(List<Character> characters, String title) {
    //Show bottom Modal
    return characters[0];
  }

  String selectOf(String title, String s1, String s2) {
    //Show popup with two options
    return s1;
  }

  @override
  Widget build(BuildContext context) {
    Game.instance.showMessage = showMessage;
    Game.instance.selectCharacter = selectCharacter;
    Game.instance.selectOf = selectOf;
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {
                setState(() {
                  Game.instance.previous();
                  widget.update();
                })
              },
              child: const Text('Zurück'),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () => {
                setState(() {
                  Game.instance.next();
                  widget.update();
                })
              },
              child: const Text('Weiter'),
            ),
          ],
        ),
      ),
    );
  }
}
