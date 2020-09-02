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
  /// Testing the card class.
  test('Card Test', () {
    /// Testing the constructor with valid parameters and expecting a succesfully
    /// created instance of the class.
    var card = GamingCard(num: 1, suit: Suit.BASTONI);
    expect(card.num, 1);
    expect(card.suit, Suit.BASTONI);
    expect(card.val, 10);

    /// Testing the constructor with invvalid parameters and expecting an
    /// exception to be thrown.
    try {
      GamingCard(num: 11, suit: Suit.BASTONI);
    } catch (e) {
      expect(e.runtimeType, WrongCardNumberException);
    }
  });

  /// Testing the card class.
  test('Deck Test', () {
    /// Testing the constructor expecting a succesfully created instance of
    /// the class.
    var deck = Deck();

    expect(deck.cards.length, 0);

    /// Testing the init method. The number of cards should now be 40.
    deck.init();
    expect(deck.cards.length, 40);

    deck.shuffle();
    expect(deck.cards.length, 40);

    /// Trying to pick a card. The number of the deck cards should decrease by
    /// the number of picked cards.
    var card = deck.pick();
    expect(card.runtimeType, GamingCard);
    expect(card != null, true);
    expect(deck.cards.length, 39);

    var cards = deck.picks(5);
    expect(cards.length, 5);
    expect(deck.cards.length, 34);

    deck.picks(34);
    expect(deck.cards.length, 0);

    /// Trying to pick from an empty deck. An exception should be thrown.
    try {
      deck.pick();
    } catch (e) {
      expect(e.runtimeType, OutOfBoundException);
    }
  });

  /// Testing the player class.
  test('Player Test', () {
    //
    /// Testing the constructor of the class.
    var player = Player(id: 'Player');
    expect(player.id, 'Player');
    expect(player.hand.length, 0);
    expect(player.matchScore, 0);
    expect(player.gameScore, 0);

    /// Adding some cards to the player hand.
    var hand = <GamingCard>[];
    hand.add(GamingCard(num: 5, suit: Suit.BASTONI));
    hand.add(GamingCard(num: 6, suit: Suit.COPPE));
    hand.add(GamingCard(num: 7, suit: Suit.ORI));
    player.hand = hand;

    /// Trying to drop a card. The number of cards should decrease by one.
    expect(player.hand.length, 3);
    expect(player.drop() != null, true);
    var deleted = player.delete();
    expect(player.hand.length, 2);

    /// Trying to pick a card.  The number of cards should increase by one.
    player.pick(deleted);
    expect(player.hand.length, 3);

    player.setGameScore = 5;
    player.setGameScore = 3;
    expect(player.gameScore, 8);

    player.setMatchScore = 1;
    player.setMatchScore = 2;
    expect(player.matchScore, 3);
  });

  /// Testing the Briscola class.
  test('Briscola Chiamata Test', () {
    //
    /// Testing the constructor of the class.
    var game = BriscolaChiamata();
    //
    expect(game.runtimeType, BriscolaChiamata);
    expect(game.deck.cards.length, 0);
    expect(game.players.isEmpty, true);

    /// Adding some players to the game instance.
    game.addPlayer(id: 'Player1');
    game.addPlayer(id: 'Player2');
    game.addPlayer(id: 'Player3');
    game.addPlayer(id: 'Player4');
    game.addPlayer(id: 'Player5');
    expect(game.players.length, 5);

    /// Trying to add more players then the game supports. An exception should
    /// be thrown.
    try {
      game.addPlayer(id: 'Player6');
    } catch (e) {
      expect(e.runtimeType, OutOfBoundException);
    }

    /// Simulating the beginning of the game, spreading a certain number of
    /// cards to each player.
    game.start();
    expect(game.cards.length, 0);
    expect(game.players.length, 5);
    game.players.forEach((player) => expect(player.hand.length, 8));

    /// Testing a single game round. Expecting every player dropped a card and
    /// later pick one.
    game.gameround();
    game.players.forEach((player) => expect(player.hand.length, 7));

    for (var i = 0; i < 7; i++) {
      game.gameround();
    }
    game.players.forEach((player) => expect(player.hand.length, 0));

    var sum = 0;
    game.players.forEach((player) {
      expect(player.matchScore, 0);
      sum += player.gameScore;
    });

    /// Checking the total amount of cards score.
    expect(sum, (2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10) * 4);
  });

  test('Briscola Test', () {
    //
    var game = Briscola();
    //
    expect(game.runtimeType, Briscola);
    expect(game.deck.cards.length, 0);
    expect(game.players.isEmpty, true);
    expect(game != null, true);

    var numplayers = 4;
    var numcards = 3;

    for (var i = 0; i < numplayers; i++) {
      game.addPlayer(id: 'Player $i');
    }

    expect(game.players.length, 4);

    try {
      game.addPlayer(id: 'Player 5');
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

  test('Settings Test', () {
    var setting = Settings(
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
