import 'package:pickr/classes/card.dart';

class Player {
  //
  List<GamingCard> _cards;
  String _id;
  int _gameScore;
  int _matchScore;

  Player({String id}) {
    _id = id;
    _cards = <GamingCard>[];
    _gameScore = 0;
    _matchScore = 0;
  }

  /// Getter method for [_cards].
  List<GamingCard> get hand => _cards;

  String get id => _id;

  /// Setter method for [_cards].
  set hand(List<GamingCard> cards) => _cards = cards;

  /// Drops the first card
  ///
  /// The user should decide which card to drop, this is for semplicity.
  GamingCard drop() => _cards.first;

  /// Getter method for [_gameScore].
  int get gameScore => _gameScore;

  /// Setter method for [_gameScore].
  set setGameScore(int gameScore) => _gameScore += gameScore;

  /// Getter method for [_matchScore].
  int get matchScore => _matchScore;

  /// Setter method for [_matchScore].
  set setMatchScore(int matchScore) => _matchScore += matchScore;

  /// Removes the first card of the hand
  GamingCard delete() => _cards.removeAt(0);

  /// Picks a card and adds it to the hand
  void pick(GamingCard card) => _cards.add(card);
}
