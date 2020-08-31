import 'package:pickr/classes/card.dart';
import 'package:pickr/classes/games/game.dart';
import 'package:pickr/classes/player.dart';
import 'package:pickr/enums/suits.dart';
import 'package:pickr/exceptions/out_of_bound_exception.dart';

class BriscolaChiamata extends Game {
  //
  /// Number of beginning cards for each player.
  final int _numplayers = 5;

  /// Number of players.
  ///
  /// DEBUG: this value is set to 4 for debug purposes. Its real values should
  /// be selected by the user in the game options selection page.
  final int _numcards = 8;

  /// Briscola suit selected for the game
  Suit _briscola;

  @override
  void start() {
    //
    deck.init();

    deck.shuffle();

    _briscola = deck.cards.last.suit;

    spread();
  }

  @override
  void addPlayer({String id}) {
    if (players.length <= _numplayers - 1) {
      players.add(Player(id: id));
    } else {
      throw OutOfBoundException();
    }
  }

  @override
  void spread() {
    players.forEach((player) {
      player.hand = deck.picks(_numcards);
    });
  }

  @override
  void gameround() {
    players.forEach((player) => dropCard(card: player.drop()));

    var winningCard = rule();

    winner(winningCard);

    table.clear();
  }

  @override
  GamingCard rule() {
    var winningCard = table.first;

    table.forEach((card) {
      if (card.val > winningCard.val) {
        // T T T
        if (winningCard.suit == _briscola && card.suit == _briscola) {
          winningCard = card;
        }
        // T F F
        if (winningCard.suit != _briscola && card.suit != _briscola) {
          winningCard = card;
        }
      }
      // F T F
      else if (card.suit == _briscola && winningCard.suit != _briscola) {
        winningCard = card;
      }
    });

    return winningCard;
  }
}
