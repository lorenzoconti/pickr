import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickr/providers/game-provider.dart';

class LobbyPage extends StatefulWidget {
  //

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<LobbyPage> {
  //

  @override
  Widget build(BuildContext context) {
    //
    var game = GameProvider.of(context).game;

    print(game.check());

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Game Lobby',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Text('Players: 1/4, waiting ...'),
                SizedBox(height: 30),
                Text(game.lobby ?? 'Empty')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
