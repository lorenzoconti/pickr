import 'package:flutter/material.dart';
import 'package:pickr/handlers/game.dart';

class GameProvider extends InheritedWidget {
  //
  const GameProvider({Key key, Widget child, this.game})
      : super(key: key, child: child);

  final GameSessionInterface game;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static GameProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: GameProvider);
  }
}
