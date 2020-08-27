import 'package:pickr/enums/suits.dart';
import 'package:pickr/exceptions/card_number_exception.dart';

class GamingCard {
  Suit _suit;
  int _num;
  int _val;

  GamingCard({Suit suit, int num}) {
    this._suit = suit;
    this._val = _numToVal(num: num);
    this._num = _checkNum(num: num);
  }

  /// Getter method for [_suit].
  Suit get suit => this._suit;

  /// Getter method for [_num].
  int get num => this._num;

  /// Getter method for [_val].
  int get val => this._val;

  /// Assigns the value of the card according to its number [_num].
  int _numToVal({int num}) {
    if (num != 1 && num != 3)
      return num - 2;
    else
      return num == 1 ? 10 : 9;
  }

  /// Check whether the card number is valid or not.
  int _checkNum({int num}) {
    if (num < 1 || num > 10) {
      throw WrongCardNumberException();
    }
    return num;
  }
}
