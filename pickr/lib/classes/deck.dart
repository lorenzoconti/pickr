import 'package:pickr/enum/suits.dart';
import 'package:quiver/iterables.dart';

import 'card.dart';

class Deck {
  List<GameCard> _cards;
  Deck();

  /// Creates a standard deck, composed of 10 different cards of each suit
  void init() {
    _cards = List<GameCard>();
    for (var num in range(1, 11))
      for (var suit in Suit.values) _cards.add(GameCard(num: num, suit: suit));
  }

  /// Randomly sort the deck
  void shuffle() => this._cards.shuffle();

  /// Returns the first card of the deck
  GameCard pick() => _cards.isNotEmpty ? _cards.removeAt(0) : null;

  /// Retunrs the last [n] cards of the deck
  List<GameCard> pickSome(int n) {
    if (_cards.length > 3) {
      List<GameCard> cards = List<GameCard>();
      for (int i = 0; i < n; i++) cards.add(_cards.removeAt(0));
      return cards;
    }
    return null;
  }

  /// Utility method: prints the entire deck
  void show() => _cards.forEach((print));

  /// Utility method: prints the number of cards in the deck
  void noc() => print(_cards.length);
}
