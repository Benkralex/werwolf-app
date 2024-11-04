import 'package:flutter/material.dart';
import 'package:werwolfapp/main.dart';
import 'package:werwolfapp/settings/settings.dart';

class MainMenu extends StatefulWidget {
  final int selectedIndex;

  const MainMenu({super.key, required this.selectedIndex});

  @override
  // ignore: library_private_types_in_public_api
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  void navigateTo(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const WerwolfApp(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              const SettingsScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: navigateTo,
      selectedIndex: selectedIndex,
      children: [
        DrawerHeader(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.asset(
                  "assets/icons/werwolf-icon.png",
                  fit: BoxFit.cover,
                  width: 64,
                  height: 64,
                ),
              ),
              const Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: 8),
              ),
              Text(
                "Werwolf Spiel",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.play_arrow_outlined),
          selectedIcon: Icon(Icons.play_arrow),
          label: Text("Spielen"),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.bookmark_outlined),
          selectedIcon: Icon(Icons.bookmark),
          label: Text("Vorlagen"),
          enabled: false,
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text("Einstellungen"),
        ),
      ],
    );
  }
}



/*
Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: primaryColor,
            ),
            child: const Text(
              'Werwolf Spiel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.play_arrow),
            title: const Text('Spielen'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const WerwolfApp(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
          ),
          Opacity(
            opacity: 0.3,
            child: ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Vorlagen'),
              onTap: () {
                //open SettingsScreen
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );*/
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Einstellungen'),
            onTap: () {
              //open SettingsScreen
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const SettingsScreen(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
          )
        ],
      ),
    );*/