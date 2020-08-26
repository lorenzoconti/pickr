import 'package:pickr/classes/games/game.dart';
import 'package:pickr/exceptions/out_of_bound_exception.dart';

import '../player.dart';

class Briscola extends Game {
  int _numcards = 3;

  Briscola();

  @override
  void start() {
    deck.init();
    deck.shuffle();
    spread();
    deck.show();
  }

  @override
  void addPlayer({String id}) {
    if (players.length < numplayers )
      players.add(Player(id: id));
    else
      throw OutOfBoundException();
  }

  @override
  void spread() {
    players.forEach((player) {
      player.hand = deck.picks(_numcards);
    });
  }
}
