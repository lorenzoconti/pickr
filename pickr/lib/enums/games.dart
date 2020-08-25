enum GameType { BRISCOLA_CHIAMATA, BRISCOLA, MARIANNA, DOMINO }

extension ParseToString on GameType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
