import 'package:flutter/material.dart';
import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/game.dart';
import 'package:werwolfapp/main.dart';

class DayWidget extends StatefulWidget {
  final Function update;

  const DayWidget({super.key, required this.update});

  @override
  // ignore: library_private_types_in_public_api
  _DayWidgetState createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  Character? selectedCharacter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: Game.game.getAliveCharacters().length,
              itemBuilder: (context, index) {
                final character = Game.game.getAliveCharacters()[index];
                final isSelected = selectedCharacter == character;
                return ListTile(
                  title: Text(character.role.name),
                  subtitle: Text(character.playerName ?? ""),
                  selected: isSelected,
                  selectedTileColor: primaryColor,
                  selectedColor: Colors.white,
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onTap: () {
                    setState(() {
                      selectedCharacter = isSelected ? null : character;
                    });
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(primaryColor),
              foregroundColor: WidgetStateProperty.all(Colors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            onPressed: () {
              if (selectedCharacter != null) {
                setState(() {
                  selectedCharacter!.kill();
                  Game.game.setNight();
                  widget.update();
                });
              }
            },
            child: const Text('Spieler lynchen!'),
          ),
        ),
      ],
    );
  }
}
