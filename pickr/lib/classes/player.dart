import 'package:pickr/classes/card.dart';

class Player {
  //
  List<GamingCard> _cards;
  String _id;
  int _gameScore;
  int _matchScore;

  Player({String id}) {
    this._id = id;
    this._cards = List<GamingCard>();
    this._gameScore = 0;
    this._matchScore = 0;
  }

  /// Getter method for [_cards].
  List<GamingCard> get hand => _cards;

  String get id => this._id;

  /// Setter method for [_cards].
  set hand(List<GamingCard> cards) => this._cards = cards;

  /// Drops the first card
  ///
  /// The user should decide which card to drop, this is for semplicity.
  GamingCard drop() => this._cards.first;

  /// Getter method for [_gameScore].
  int get gameScore => this._gameScore;

  /// Setter method for [_gameScore].
  set setGameScore(int gameScore) => this._gameScore += gameScore;

  /// Getter method for [_matchScore].
  int get matchScore => this._matchScore;

  /// Setter method for [_matchScore].
  set setMatchScore(int matchScore) => this._matchScore += matchScore;

  /// Removes the first card of the hand
  GamingCard delete() => this._cards.removeAt(0);

  /// Picks a card and adds it to the hand
  void pick(GamingCard card) => this._cards.add(card);
}
