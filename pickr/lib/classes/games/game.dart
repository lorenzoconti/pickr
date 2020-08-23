import 'package:pickr/classes/card.dart';
import 'package:pickr/classes/deck.dart';
import 'package:pickr/classes/games/settings.dart';
import 'package:pickr/classes/player.dart';

abstract class Game {
  int _round = 1;
  Deck _deck;
  List<GamingCard> _table;
  List<Player> _players;
  GameSettings _settings;

  Game({GameSettings settings}) {
    _deck = Deck();
    _table = List<GamingCard>();
    _players = List<Player>();
    this._settings = settings;
  }

  get deck => _deck;
  get players => _players;
  get round => _round;
  get table => _table;
  get cards => _deck.cards;
  get settings => _settings;

  void addPlayer({String id});

  void dropCard({GamingCard card}) => _table.add(card);

  void clearTable() => _table.clear();

  void start();
}
