import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickr/handlers/game.dart';
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
    GameSession game = GameProvider.of(context).game;

    print(game.check());

    return Scaffold(
        body: Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Container(child: Text(game.lobby != null ? game.lobby : " NULL")),
    ));
  }
}
