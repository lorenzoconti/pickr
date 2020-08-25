import 'package:flutter/material.dart';
import 'package:pickr/classes/card.dart';
import 'package:pickr/classes/deck.dart';
import 'package:pickr/classes/player.dart';

abstract class Game {
  //

  int numplayers;
  int score;
  int _round = 1;
  Deck _deck;
  List<GamingCard> _table;
  List<Player> _players;

  Game({@required int numplayers, @required int score}) {
    numplayers = numplayers;
    score = score;
    _deck = Deck();
    _table = List<GamingCard>();
    _players = List<Player>();
  }

  Deck get deck => _deck;
  List<Player> get players => _players;
  int get round => _round;
  List<GamingCard> get table => _table;
  List<GamingCard> get cards => _deck.cards;

  void spread();

  // GamingCard rule();

  void addPlayer({String id});

  void dropCard({GamingCard card}) => _table.add(card);

  void clearTable() => _table.clear();

  void start();
}
