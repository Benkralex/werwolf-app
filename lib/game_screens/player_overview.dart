import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/game.dart';
import 'package:werwolfapp/main.dart';

class PlayerOverviewScreen extends StatefulWidget {
  const PlayerOverviewScreen({super.key});

  @override
  State<PlayerOverviewScreen> createState() => _PlayerOverviewScreenState();
}

class _PlayerOverviewScreenState extends State<PlayerOverviewScreen> {
  void editProperties(Character character) {
    final properties = character.getProperties();
    List<Widget> propertiesWidgets = [];

    properties.forEach((p, value) {
      Widget input;
      if (value is bool) {
        bool switchValue = value;
        input = StatefulBuilder(
          builder: (context, setState) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(p.toString()),
                Switch(
                  thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
                    (Set<WidgetState> states) {
                      if (switchValue) {
                        return const Icon(Icons.check);
                      }
                      return const Icon(Icons.close);
                    },
                  ),
                  value: switchValue,
                  onChanged: (newValue) {
                    setState(() {
                      switchValue = newValue;
                      character.setProperty(p, newValue);
                    });
                  },
                ),
              ],
            );
          },
        );
      } else if (value is int) {
        final controller = TextEditingController(text: value.toString());
        input = TextField(
          decoration: InputDecoration(labelText: p.toString()),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          controller: controller,
          onChanged: (newValue) {
            character.setProperty(p, int.tryParse(newValue) ?? value);
          },
        );
      } else {
        final controller = TextEditingController(text: value.toString());
        input = TextField(
          decoration: InputDecoration(labelText: p.toString()),
          controller: controller,
          onChanged: (newValue) {
            character.setProperty(p, newValue);
          },
        );
      }
      propertiesWidgets.add(input);
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Charakter Eigenschaften'),
          content: SingleChildScrollView(
            child: Column(
              children: propertiesWidgets,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Schließen'),
            ),
          ],
        );
      },
    );
  }

  void editCharacter(Character character) {
    String playerName = character.playerName ?? "";
    String notes = character.notes ?? "";
    TextEditingController playerNameController =
        TextEditingController(text: playerName);
    TextEditingController notesController = TextEditingController(text: notes);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Spieler bearbeiten'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  playerName = value;
                },
                controller: playerNameController,
                maxLength: 10,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                inputFormatters: [LengthLimitingTextInputFormatter(20)],
                decoration: const InputDecoration(labelText: 'Spielername'),
              ),
              TextField(
                onChanged: (value) {
                  notes = value;
                },
                controller: notesController,
                decoration: const InputDecoration(labelText: 'Notizen'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Abbrechen'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  character.playerName = playerName;
                  character.notes = notes;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Speichern'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> getPlayers() {
    List<Widget> players = [];
    List<Character> characters = Game.game.characters;

    characters.sort((a, b) => a.role.priority.compareTo(b.role.priority));
    characters.sort((a, b) => (b.alive ? 1 : 0) - (a.alive ? 1 : 0));

    for (final c in characters) {
      players.add(
        ListTile(
          title: Text(
            c.role.name,
            style: TextStyle(color: c.alive ? Colors.white : Colors.grey),
          ),
          subtitle: Text(
            c.playerName ?? "",
            style: TextStyle(color: c.alive ? Colors.white : Colors.grey),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    c.alive ? c.kill() : c.revive();
                  });
                },
                icon: Icon(c.alive ? Icons.heart_broken : Icons.favorite),
                color: secondaryIconsColor,
              ),
              IconButton(
                onPressed: () {
                  editCharacter(c);
                },
                icon: const Icon(Icons.edit),
                color: primaryIconsColor,
              ),
              IconButton(
                onPressed: () {
                  editProperties(c);
                },
                icon: const Icon(Icons.settings),
                color: secondaryIconsColor,
              ),
            ],
          ),
        ),
      );
    }
    return players;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spieler'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.home),
            color: menuIconsColor,
          ),
        ],
      ),
      body: ListView(children: getPlayers()),
    );
  }
}
