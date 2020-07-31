import 'package:pickr/classes/games/game.dart';
import 'package:pickr/models/scoped_main.dart';
import 'package:pickr/classes/games/briscola.dart';
import 'package:pickr/classes/user.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'pages/page_home.dart';

void main() => runApp(Pickr());

class Pickr extends StatelessWidget {
  final MainModel _model = MainModel();

  @override
  Widget build(BuildContext context) {
    //
    Game game = Briscola();

    game.addPlayer(User(id: "Lorenzo", email: "Lorenzo"));
    game.addPlayer(User(id: "Mattia", email: "Mattia"));
    game.addPlayer(User(id: "Andrea", email: "Andrea"));
    game.addPlayer(User(id: "Flavia", email: "Flavia"));
    game.addPlayer(User(id: "Martina", email: "Martina"));

    game.start();

    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pickr',
        routes: {'/': (BuildContext context) => HomePage()},
      ),
    );
  }
}
