import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:werwolfapp/character_config.dart';
import 'package:werwolfapp/game/character.dart';
import 'package:werwolfapp/game/game.dart';
import 'package:werwolfapp/game/role.dart';
import 'package:werwolfapp/game/role_repository.dart';
import 'package:werwolfapp/main.dart';
import 'package:werwolfapp/menu.dart';

class CharacterInputScreen extends StatefulWidget {
  const CharacterInputScreen({super.key});

  @override
  CharacterInputScreenState createState() => CharacterInputScreenState();
}

class CharacterInputScreenState extends State<CharacterInputScreen> {
  List<Character> characters = [];
  int charactersCount = 0;

  void _showRoleSelectionSheet() async {
    final Role? selectedRole = await showModalBottomSheet<Role>(
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: (RoleRepository.roles.isNotEmpty)
                    ? RoleRepository.roles.map((Role role) {
                        if (characters
                            .where((element) => element.role.name == role.name)
                            .isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              title: Text(role.name),
                              onTap: () {
                                Navigator.of(context).pop(role);
                              },
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }).toList()
                    : [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text("no_roles").tr(),
                        ),
                      ],
              ),
            );
          },
        );
      },
    );
    if (selectedRole != null) {
      setState(() {
        characters.add(Character(role: selectedRole));
        charactersCount = characters.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> characterCount = {};

    characters.sort((a, b) => a.id.compareTo(b.id));
    characters.sort((a, b) => a.role.name.compareTo(b.role.name));
    characters.sort((a, b) => a.role.priority.compareTo(b.role.priority));
    for (var character in characters) {
      characterCount[character.role.name] =
          (characterCount[character.role.name] ?? 0) + 1;
    }

    List<Widget> characterWidgets = characterCount.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ListTile(
          title: Row(
            children: [
              Text('${entry.value}'),
              const SizedBox(width: 8.0),
              Text(entry.key),
            ],
          ),
          trailing: SizedBox(
            width: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: (entry.value == 1)
                      ? const Icon(Icons.delete)
                      : const Icon(Icons.remove),
                  color: primaryIconsColor,
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < characters.length; i++) {
                        if (characters[i].role.name == entry.key) {
                          characters.removeAt(i);
                          charactersCount = characters.length;
                          break;
                        }
                      }
                    });
                  },
                ),
                IconButton(
                  onPressed: (RoleRepository.roles
                              .firstWhere(
                                  (element) => element.name == entry.key)
                              .maxCount >
                          entry.value)
                      ? () {
                          setState(() {
                            Role role = RoleRepository.roles.firstWhere(
                                (element) => element.name == entry.key);
                            characters.add(Character(role: role));
                            charactersCount = characters.length;
                          });
                        }
                      : null,
                  icon: const Icon(Icons.add),
                  color: primaryIconsColor,
                  disabledColor: primaryIconsColorDisabled,
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('character').plural(2),
        actions: [
          IconButton(
            onPressed: _showRoleSelectionSheet,
            icon: const Icon(Icons.add),
            color: menuIconsColor,
          ),
        ],
      ),
      drawer: const MainMenu(
        selectedIndex: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Text("characters_in_total").tr(args: [charactersCount.toString()]),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: characterWidgets,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (characters.length < 5 || characters.length > 40) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "characters_min_max_count",
                ).tr(),
              ),
            );
            return;
          }
          if (characters.every((c) => c.role.priority == 0)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "characters_min_on_at_night_awake",
                ).tr(),
              ),
            );
            return;
          }
          Game.instance.playerCount = characters.length;
          Game.instance.characters = characters;
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const CharacterConfig(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
