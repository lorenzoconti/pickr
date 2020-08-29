enum Suit { ORI, SPADE, BASTONI, COPPE }

extension ParseToString on Suit {
  String toShortString() {
    return toString().split('.').last;
  }
}
