import 'package:flutter/material.dart';
import 'package:pickr/handlers/game.dart';
import 'package:pickr/pages/auth.dart';
import 'package:pickr/pages/lobby.dart';
import 'package:pickr/providers/auth-provider.dart';
import 'package:pickr/providers/game-provider.dart';

import 'handlers/auth.dart';
import 'pages/home.dart';

void main() => runApp(Pickr());

class Pickr extends StatelessWidget {
  /// Builds the app.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: GameProvider(
        game: GameSession(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pickr',
          routes: {
            '/': (BuildContext context) => AuthPage(),
            '/home': (BuildContext context) => HomePage(),
            '/lobby': (BuildContext context) => LobbyPage(),
          },
        ),
      ),
    );
  }
}
