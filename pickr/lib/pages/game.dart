import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    //GameSession game = GameProvider.of(context).game;

    return Scaffold(
      appBar: AppBar(title: Text("Game")),
      body: Container(child: Center(child: Text("Game"))),
    );
  }
}
