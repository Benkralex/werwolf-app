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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => {
                  setState(() {
                    Game.game.previous();
                    widget.update();
                  })
                },
                child: const Text('Prev'),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              ElevatedButton(
                onPressed: () => {
                  setState(() {
                    Game.game.next();
                    widget.update();
                  })
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
