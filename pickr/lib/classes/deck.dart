import 'package:pickr/exceptions/out_of_bound_exception.dart';
import 'package:quiver/iterables.dart';

import 'package:pickr/classes/card.dart';
import 'package:pickr/enums/suits.dart';

class Deck {
  List<GamingCard> _cards;

  Deck() {
    _cards = List<GamingCard>();
  }

  get cards => _cards;

  void init() {
    for (var num in range(1, 11))
      for (var suit in Suit.values)
        _cards.add(GamingCard(num: num, suit: suit));
  }

  void shuffle() => this._cards.shuffle();

  GamingCard pick() =>
      _cards.isNotEmpty ? _cards.removeAt(0) : throw OutOfBoundException();

  List<GamingCard> picks(int n) {
    if (_cards.length >= n) {
      List<GamingCard> _pickedcards = List<GamingCard>();
      for (int i = 0; i < n; i++) _pickedcards.add(_cards.removeAt(0));
      return _pickedcards;
    } else
      throw OutOfBoundException();
  }

  void show() => _cards.forEach((print));

  int noc() => _cards.length;
}
