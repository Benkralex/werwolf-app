import 'role.dart';

class RoleRepository {
  static List<Role> roles = [];

  static void addToRoles(Role role) {
    roles.add(role);
  }

  static List<Map<String, dynamic>> saveJsonList() {
    List<Map<String, dynamic>> jsonList = [];
    for (var role in roles) {
      jsonList.add(role.toJSON());
    }
    return jsonList;
  }

  static List<Role> loadJsonList(List<Map<String, dynamic>> jsonList) {
    List<Role> roles = [];
    for (var roleJson in jsonList) {
      roles.add(Role.fromJSON(roleJson));
    }
    return roles;
  }

  static Role getRole(int id) {
    for (final r in roles) {
      if (r.id == id) {
        return r;
      }
    }
    return roles[0];
  }

  static Role getRoleByName(String name) {
    for (final r in roles) {
      if (r.name == name) {
        return r;
      }
    }
    return roles[0];
  }
}
