import 'package:flutter_test/flutter_test.dart';
import 'package:pickr/classes/card.dart';
import 'package:pickr/classes/deck.dart';
import 'package:pickr/classes/games/briscola_chiamata.dart';
import 'package:pickr/exceptions/out_of_bound_exception.dart';

void main() {
  //
  test('Deck Test', () {
    Deck deck = Deck();

    expect(deck.noc(), 0);

    deck.init();
    expect(deck.noc(), 40);

    deck.shuffle();
    expect(deck.noc(), 40);

    var card = deck.pick();
    expect(card.runtimeType, GamingCard);
    expect(card != null, true);
    expect(deck.noc(), 39);

    var cards = deck.picks(5);
    expect(cards.length, 5);
    expect(deck.noc(), 34);

    deck.picks(34);
    expect(deck.noc(), 0);

    try {
      deck.pick();
    } catch (e) {
      expect(e.runtimeType, OutOfBoundException);
    }
  });

  test('Game Test', () {
    Briscola game = Briscola();
    //
    expect(game.runtimeType, Briscola);
    expect(game.cards.length, 0);
    expect(game.players.isEmpty, true);

    game.addPlayer(id: "Player1");
    game.addPlayer(id: "Player2");
    game.addPlayer(id: "Player3");
    game.addPlayer(id: "Player4");
    game.addPlayer(id: "Player5");
    expect(game.players.length, 5);

    try {
      game.addPlayer(id: "Player6");
    } catch (e) {
      expect(e.runtimeType, OutOfBoundException);
    }

    game.start();
    expect(game.cards.length, 0);
    expect(game.players.length, 5);
    game.players.forEach((player) => expect(player.hand.length, 8));
  });
}
