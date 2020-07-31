enum GameType { BRISCOLA, MARIANNA, DOMINO }

extension ParseToString on GameType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
