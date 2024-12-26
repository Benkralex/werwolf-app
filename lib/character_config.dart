import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:werwolfapp/game/action.dart';
import 'package:werwolfapp/game/game.dart';
import 'package:werwolfapp/game/role.dart';
import 'package:werwolfapp/game/role_repository.dart';
import 'package:werwolfapp/game_screens/game_overview.dart';

Map<Role, Map<String, dynamic>> _characterProperties = {
  for (var role in RoleRepository.roles) role: role.properties
};

class CharacterConfig extends StatelessWidget {
  void propertiesDialog(int id, BuildContext context) {
    final role = RoleRepository.getRole(id);
    final Map<String, dynamic> roleProperties =
        _characterProperties[role] ?? {};
    List<Widget> properties = [];

    roleProperties.forEach((p, value) {
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
                      return switchValue
                          ? const Icon(Icons.check)
                          : const Icon(Icons.close);
                    },
                  ),
                  value: switchValue,
                  onChanged: (newValue) {
                    setState(() {
                      switchValue = newValue;
                      _characterProperties[role]![p] = newValue;
                      Game.instance.configAllCharacters(role, p, newValue);
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
            final parsedValue = int.tryParse(newValue) ?? value;
            _characterProperties[role]![p] = parsedValue;
            Game.instance.configAllCharacters(role, p, parsedValue);
          },
        );
      } else {
        final controller = TextEditingController(text: value.toString());
        input = TextField(
          decoration: InputDecoration(labelText: p.toString()),
          controller: controller,
          onChanged: (newValue) {
            _characterProperties[role]![p] = newValue;
            Game.instance.configAllCharacters(role, p, newValue);
          },
        );
      }
      properties.add(input);
    });

    if (properties.isEmpty) {
      properties.add(const Text('no_properties').tr());
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('properties'.plural(2) + role.name),
          content: SingleChildScrollView(
            child: Column(
              children: properties,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('close').tr(),
            ),
          ],
        );
      },
    );
  }

  const CharacterConfig({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = Game.instance.listUsedRoles().map<Widget>((role) {
      return GestureDetector(
        onTap: () {
          propertiesDialog(role.id, context);
        },
        child: Card(
          child: ListTile(
            title: Text(role.name),
          ),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('character_properties').tr(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: roles),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _characterProperties.forEach((role, properties) {
            properties.forEach((property, value) {
              Game.instance.configAllCharacters(role, property, value);
            });
          });
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  const GameOverviewScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
          GameAction.nextUpdatesDay = false;
          Game.instance.next();
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
