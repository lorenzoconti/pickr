import 'package:flutter/cupertino.dart';
import 'package:pickr/enum/suits.dart';

class GameCard {
  Suit suit;
  int num;

  GameCard({@required this.suit, @required this.num})
      : assert(num > 0 && num < 11);

  String toString() => this.num.toString() + " di " + this.suit.toShortString();
}
