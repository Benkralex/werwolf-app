import 'package:flutter/material.dart';
import 'package:werwolfapp/character_input.dart';
import 'package:werwolfapp/game/role.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Color primaryColor = Colors.indigo;
Color menuIconsColor = Colors.white;
Color primaryIconsColor = Colors.blue[200]!;
Color secondaryIconsColor = Colors.blue[50]!;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadRoles();
  runApp(const MyApp());
}

Future<void> loadRoles() async {
  final String jsonString =
      await rootBundle.loadString('assets/game-config/roles.json');
  final List<dynamic> jsonList = json.decode(jsonString);
  final List<Map<String, dynamic>> mappedJsonList =
      jsonList.cast<Map<String, dynamic>>();
  Role.roles = Role.loadJsonList(mappedJsonList);
  Role.roles.sort((a, b) => a.priority.compareTo(b.priority));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
