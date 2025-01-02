import 'package:werwolfapp/new_game_mechanics/role.dart';

class Player {
  final Role role;
  final int id;
  String notes = "";
  String name = "";
  bool alive = true;
  Map<String, dynamic> properties;

  Player({required this.role, required this.id})
      : properties = Map<String, dynamic>.from(role.properties);
}
