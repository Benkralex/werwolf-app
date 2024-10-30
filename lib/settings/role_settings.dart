import 'package:flutter/material.dart';
import 'package:werwolfapp/game/role_repository.dart';
import 'package:werwolfapp/main.dart';

class RoleSettingsScreen extends StatelessWidget {
  const RoleSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rollen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: RoleRepository.roles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 16.0), // Abstand zum linken Rand
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Links bündig
              children: [
                Text(
                  RoleRepository.roles[index].name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryIconsColor,
                  ),
                ),
                const SizedBox(height: 6), // Abstand zwischen den Texten
                Text(
                  RoleRepository.roles[index].desc,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(255, 255, 255, 1),
                  ),
                  textAlign: TextAlign.left, // Text linksbündig
                ),
                const SizedBox(height: 12),
              ],
            ),
          );
        },
      ),
    );
  }
}
