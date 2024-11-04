import 'package:flutter/material.dart';
import 'package:werwolfapp/character_input.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:werwolfapp/game/role_repository.dart';
import 'package:werwolfapp/game/win_group.dart';

Color primaryColor = Colors.indigo;
Color menuIconsColor = Colors.white;
Color primaryIconsColor = Colors.blue[200]!;
Color secondaryIconsColor = Colors.blue[50]!;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadWinGroups();
  await loadRoles();
  runApp(const WerwolfApp());
}

Future<void> loadRoles() async {
  final String jsonString =
      await rootBundle.loadString('assets/game-config/roles.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  final List<Map<String, dynamic>> mappedJsonList =
      jsonList.cast<Map<String, dynamic>>();
  RoleRepository.roles = RoleRepository.loadJsonList(mappedJsonList);
  RoleRepository.roles.sort((a, b) => a.priority.compareTo(b.priority));
}

Future<void> loadWinGroups() async {
  final String jsonString =
      await rootBundle.loadString('assets/game-config/win-groups.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  final List<Map<String, dynamic>> mappedJsonList =
      jsonList.cast<Map<String, dynamic>>();
  WinGroup.winGroups = WinGroup.loadJsonList(mappedJsonList);
}

class WerwolfApp extends StatelessWidget {
  const WerwolfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Werwolf",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.dark,
        ),
      ),
      home: const CharacterInputScreen(),
    );
  }
}
