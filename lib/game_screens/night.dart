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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<Character> selectCharacter(
      List<Character> characters, String title) async {
    while (true) {
      final selectedCharacter = await showModalBottomSheet<Character>(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                color: Colors.grey[200],
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: characters.map((character) {
                      return ListTile(
                        title: Text(character.role.name),
                        subtitle: Text(character.playerName ?? ""),
                        onTap: () {
                          Navigator.pop(context, character);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      );

      if (selectedCharacter != null) {
        return selectedCharacter;
      }
    }
  }

  String selectOf(String title, String s1, String s2) {
    String returnValue = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                returnValue = s1;
              },
              child: Text(s1),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                returnValue = s2;
              },
              child: Text(s2),
            ),
          ],
        );
      },
    );
    return returnValue;
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
