import 'package:easy_localization/easy_localization.dart';
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
                "title",
                style: Theme.of(context).textTheme.headlineSmall,
              ).tr(),
              Text(
                "V0.9.2-beta",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.play_arrow_outlined),
          selectedIcon: Icon(Icons.play_arrow),
          label: Text("menu_play").tr(),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.bookmark_outlined),
          selectedIcon: Icon(Icons.bookmark),
          label: Text("menu_presets").tr(),
          enabled: false,
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text("menu_settings").tr(),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
