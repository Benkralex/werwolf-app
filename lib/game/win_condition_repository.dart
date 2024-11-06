import 'package:werwolfapp/game/win_condition.dart';

class WinConditionRepository {
  static List<WinCondition> _winConditions = [];

  static void add(WinCondition winCondition) {
    _winConditions.add(winCondition);
  }

  static void remove(WinCondition winCondition) {
    _winConditions.remove(winCondition);
  }

  static void removeAll() {
    _winConditions.clear();
  }

  static List<WinCondition> getAll() {
    return _winConditions;
  }

  static WinCondition getWinCondition(int id) {
    return _winConditions.firstWhere((element) => element.id == id);
  }

  static List<WinCondition> loadJsonList(
      List<Map<String, dynamic>>? mappedJsonList) {
    if (mappedJsonList == null) {
      return [];
    }
    _winConditions.clear();
    _winConditions =
        mappedJsonList.map((e) => WinCondition.fromJson(e)).toList();
    return _winConditions;
  }
}
