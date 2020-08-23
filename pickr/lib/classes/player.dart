import 'package:pickr/classes/card.dart';

class Player {
  List<GamingCard> _cards;
  String id;

  Player({String id}) {
    this.id = id;
    this._cards = List<GamingCard>();
  }

  get hand => _cards;

  set hand(List<GamingCard> cards) => this._cards = cards;
}
