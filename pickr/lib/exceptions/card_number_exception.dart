class WrongCardNumberException implements Exception {
  @override
  String toString() {
    return 'Wrong card number! Numbers should be greater then 0 and less or equal then 10.';
  }
}
