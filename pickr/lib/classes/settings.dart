import 'package:flutter/material.dart';

import 'package:pickr/enums/games.dart';

class Settings {
  /// Type of the game (i.e Briscola, Briscola Chiamata).
  GameType type;

  /// [available] is true if the game is available in this current verison of the application, otherwise false.
  bool available;

  /// Number of selectionable options.
  int numOptions;

  /// [availableNumPlayers] is true if the number of the players is a selectionable option.
  bool availableNumPlayers;

  /// Contains the selectionable options for the game's number of players.
  List<int> numPlayers;

  /// [availableScore] is true if the number of the players is a selectionable option.
  bool availableScore;

  /// Contains the selectionable options for the game's max score.
  List<int> maxScore;

  Settings({
    @required this.type,
    this.available,
    @required this.numOptions,
    @required this.numPlayers,
    this.availableNumPlayers,
    this.availableScore,
    @required this.maxScore,
  })  : assert(type != null),
        assert(numOptions != null && numOptions >= 0 && numOptions < 3),
        assert(maxScore != null),
        assert(numPlayers != null);

  /// Returns all the information of the settings object in a string format.
  @override
  String toString() {
    return 'available: ' +
        available.toString() +
        ' numOptions: ' +
        numOptions.toString() +
        ' availablePlayers: ' +
        availableNumPlayers.toString() +
        ' numPlayers: ' +
        numPlayers.toString() +
        ' availableScore: ' +
        availableScore.toString() +
        ' maxScore: ' +
        maxScore.toString();
  }
}
