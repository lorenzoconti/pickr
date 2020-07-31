import 'package:pickr/classes/player.dart';
import 'package:pickr/classes/deck.dart';
import 'package:pickr/classes/user.dart';

abstract class Game {
  int _round = 1;
  Deck _deck = Deck();
  List<Player> _players = List<Player>();

  get deck => _deck;
  get players => _players;
  get round => _round;

  void addPlayer(User player) => players.add(Player(user: player));

  void start();
}
