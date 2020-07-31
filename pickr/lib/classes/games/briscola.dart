import 'package:flutter/material.dart';

import 'game.dart';

class Briscola extends Game {
  Briscola();

  @override
  void start() {
    deck.init();
    deck.shuffle();
    players.forEach((player) => player.hand = deck.pickSome(3));
    players.forEach(print);
    deck.show();
    deck.noc();
  }
}
