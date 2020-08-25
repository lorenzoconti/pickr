import 'package:pickr/enums/games.dart';

class Settings {
  GameType type;
  bool available;

  int numOptions;

  bool availableNumPlayers;
  List<int> numPlayers;

  bool availableScore;
  List<int> maxScore;

  Settings({
    this.type,
    this.available,
    this.numOptions,
    this.numPlayers,
    this.availableNumPlayers,
    this.availableScore,
    this.maxScore,
  })  : assert(type != null),
        assert(numOptions != null && numOptions >= 0 && numOptions < 3),
        assert(maxScore != null),
        assert(numPlayers != null);

  @override
  String toString() {
    return "available: " +
        available.toString() +
        " numOptions: " +
        numOptions.toString() +
        " availablePlayers: " +
        availableNumPlayers.toString() +
        " numPlayers: " +
        numPlayers.toString() +
        " availableScore: " +
        availableScore.toString() +
        " maxScore: " +
        maxScore.toString();
  }
}
