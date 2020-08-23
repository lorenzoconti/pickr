import 'package:pickr/classes/games/game.dart';
import 'package:pickr/classes/player.dart';
import 'package:pickr/exceptions/out_of_bound_exception.dart';

class Briscola extends Game {
  int _numplayers = 5;
  int _numcards = 8;

  @override
  void start() {
    deck.init();
    deck.shuffle();
    players.forEach((player) => player.hand = deck.picks(_numcards));
    //players.forEach(print);
    deck.show();
  }

  @override
  void addPlayer({String id}) {
    if (players.length <= _numplayers - 1)
      players.add(Player(id: id));
    else
      throw OutOfBoundException();
  }
}
