import 'package:flutter_test/flutter_test.dart';
import 'package:pickr/classes/card.dart';
import 'package:pickr/classes/deck.dart';
import 'package:pickr/classes/games/briscola.dart';
import 'package:pickr/classes/games/briscola_chiamata.dart';
import 'package:pickr/classes/player.dart';
import 'package:pickr/classes/settings.dart';
import 'package:pickr/enums/games.dart';
import 'package:pickr/enums/suits.dart';
import 'package:pickr/exceptions/card_number_exception.dart';
import 'package:pickr/exceptions/out_of_bound_exception.dart';

void main() {
  //
  test('Card Test', () {
    GamingCard card = GamingCard(num: 1, suit: Suit.BASTONI);
    expect(card.num, 1);
    expect(card.suit, Suit.BASTONI);
    expect(card.val, 10);

    try {
      GamingCard(num: 11, suit: Suit.BASTONI);
    } catch (e) {
      expect(e.runtimeType, WrongCardNumberException);
    }
  });

  test('Deck Test', () {
    Deck deck = Deck();

    expect(deck.cards.length, 0);

    deck.init();
    expect(deck.cards.length, 40);

    deck.shuffle();
    expect(deck.cards.length, 40);

    var card = deck.pick();
    expect(card.runtimeType, GamingCard);
    expect(card != null, true);
    expect(deck.cards.length, 39);

    var cards = deck.picks(5);
    expect(cards.length, 5);
    expect(deck.cards.length, 34);

    deck.picks(34);
    expect(deck.cards.length, 0);

    try {
      deck.pick();
    } catch (e) {
      expect(e.runtimeType, OutOfBoundException);
    }
  });

  test('Player Test', () {
    //
    Player player = new Player(id: "Player");
    expect(player.id, "Player");
    expect(player.hand.length, 0);
    expect(player.matchScore, 0);
    expect(player.gameScore, 0);

    List<GamingCard> hand = List<GamingCard>();
    hand.add(GamingCard(num: 5, suit: Suit.BASTONI));
    hand.add(GamingCard(num: 6, suit: Suit.COPPE));
    hand.add(GamingCard(num: 7, suit: Suit.ORI));
    player.hand = hand;

    expect(player.hand.length, 3);
    expect(player.drop() != null, true);
    GamingCard deleted = player.delete();
    expect(player.hand.length, 2);
    player.pick(deleted);
    expect(player.hand.length, 3);

    player.setGameScore = 5;
    player.setGameScore = 3;
    expect(player.gameScore, 8);

    player.setMatchScore = 1;
    player.setMatchScore = 2;
    expect(player.matchScore, 3);
  });

  test('Briscola Chiamata Test', () {
    //
    BriscolaChiamata game = BriscolaChiamata();
    //
    expect(game.runtimeType, BriscolaChiamata);
    expect(game.deck.cards.length, 0);
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

    game.gameround();
    game.players.forEach((player) => expect(player.hand.length, 7));

    for (int i = 0; i < 7; i++) game.gameround();
    game.players.forEach((player) => expect(player.hand.length, 0));

    int sum = 0;
    game.players.forEach((player) {
      expect(player.matchScore, 0);
      sum += player.gameScore;
    });

    expect(sum, (2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10) * 4);
  });

  test('Briscola Test', () {
    //
    Briscola game = Briscola();
    //
    expect(game.runtimeType, Briscola);
    expect(game.deck.cards.length, 0);
    expect(game.players.isEmpty, true);
    expect(game != null, true);

    int numplayers = 4;
    int numcards = 3;

    for (int i = 0; i < numplayers; i++) game.addPlayer(id: "Player $i");

    expect(game.players.length, 4);

    try {
      game.addPlayer(id: "Player 5");
    } catch (e) {
      expect(e.runtimeType, OutOfBoundException);
    }

    game.start();
    expect(game.round, 1);
    expect(game.cards.length, 40 - numcards * numplayers);
    expect(game.players.length, 4);
    game.players.forEach((player) => expect(player.hand.length, 3));

    game.gameround();
    game.players.forEach((player) => expect(player.hand.length, 3));
    expect(game.round, 2);
  });

  test("Settings Test", () {
    Settings setting = Settings(
        available: true,
        availableNumPlayers: true,
        availableScore: true,
        maxScore: [5],
        numOptions: 2,
        numPlayers: [5],
        type: GameType.BRISCOLA);

    expect(setting.toString() != null, true);
  });
}
