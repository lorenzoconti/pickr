import 'package:pickr/enums/suits.dart';
import 'package:pickr/exceptions/card_number_exception.dart';

class GamingCard {
  Suit suit;
  int num;
  int val;

  GamingCard({Suit suit, int num}) {
    this.suit = suit;
    this.val = _checkNum(num: num);
    this.num = _numToVal(num: num);
  }

  int _numToVal({int num}) {
    if (num != 1 && num != 3)
      return num - 1;
    else
      return num == 1 ? 10 : 9;
  }

  int _checkNum({int num}) {
    if (num < 1 || num > 10) {
      throw WrongCardNumberException();
    }
    return num;
  }
}
