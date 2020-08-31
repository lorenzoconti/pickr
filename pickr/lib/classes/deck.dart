import 'package:pickr/exceptions/out_of_bound_exception.dart';
import 'package:quiver/iterables.dart';

import 'package:pickr/classes/card.dart';
import 'package:pickr/enums/suits.dart';

class Deck {
  //
  List<GamingCard> _cards;

  Deck() {
    _cards = <GamingCard>[];
  }

  /// Getter method for [_cards].
  List<GamingCard> get cards => _cards;

  /// Initializes the deck with 40 cards, 10 different cards of each suit.
  void init() {
    for (var num in range(1, 11)) {
      for (var suit in Suit.values) {
        _cards.add(GamingCard(num: num, suit: suit));
      }
    }
  }

  /// Shuffles the deck.
  void shuffle() => _cards.shuffle();

  /// Picks the first card of the deck.
  GamingCard pick() =>
      _cards.isNotEmpty ? _cards.removeAt(0) : throw OutOfBoundException();

  /// Picks the first [n] cards of the deck.
  List<GamingCard> picks(int n) {
    if (_cards.length >= n) {
      var _pickedcards = <GamingCard>[];
      for (var i = 0; i < n; i++) {
        _pickedcards.add(_cards.removeAt(0));
      }
      return _pickedcards;
    } else {
      throw OutOfBoundException();
    }
  }
}
