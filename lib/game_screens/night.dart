import 'package:flutter/material.dart';
import 'package:werwolfapp/game/game.dart';

class NightWidget extends StatefulWidget {
  final Function update;
  const NightWidget({super.key, required this.update});

  @override
  State<NightWidget> createState() => _NightWidgetState();
}

class _NightWidgetState extends State<NightWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Your other widgets can go here
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {
                setState(() {
                  Game.instance.previous();
                  widget.update();
                })
              },
              child: const Text('Zurück'),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
              onPressed: () => {
                setState(() {
                  Game.instance.next();
                  widget.update();
                })
              },
              child: const Text('Weiter'),
            ),
          ],
        ),
      ),
    );
  }
}
