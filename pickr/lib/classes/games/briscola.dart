import 'package:pickr/classes/games/game.dart';
import 'package:pickr/exceptions/out_of_bound_exception.dart';

import '../player.dart';

class Briscola extends Game {
  int numplayers = 5;
  int _numcards = 3;

  Briscola({this.numplayers});

  @override
  void start() {
    print("Started a Briscola Game");
  }

  @override
  void addPlayer({String id}) {
    if (players.length <= numplayers - 1)
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
