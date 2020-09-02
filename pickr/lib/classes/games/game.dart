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
    _table = <GamingCard>[];
    _players = <Player>[];
  }

  /// Getter method for [_deck].
  Deck get deck => _deck;

  /// Getter method for [_round].
  int get round => _round;

  /// Getter method for [_table].
  List<GamingCard> get table => _table;

  /// Getter method for [_players].
  List<Player> get players => _players;

  /// Getter method for [_cards].
  List<GamingCard> get cards => _deck.cards;

  /// Distributes the initial cards to the players.
  void spread();

  /// Rule that determines the winner of the round.
  GamingCard rule();

  /// Adds a player to the [_players] list.
  void addPlayer({String id});

  /// Returns the amount of points of the cards on the table.
  int getTableValue() {
    var result = 0;
    table.forEach((card) {
      result += card.val;
    });
    return result;
  }

  /// Drops a card on the table
  void dropCard({GamingCard card}) => _table.add(card);

  /// Starts the game
  void start();

  /// Sequence of actions in an entire round of game.
  void gameround();

  /// Determines the winner of the round and awards him with
  /// the points it deserves.
  Player winner(GamingCard winnerCard) {
    var winner = players.first;

    _players.forEach((player) {
      if (player.hand.contains(winnerCard)) winner = player;

      player.delete();
    });

    winner.setGameScore = getTableValue();

    table.clear();

    _round += 1;

    return winner;
  }
}
