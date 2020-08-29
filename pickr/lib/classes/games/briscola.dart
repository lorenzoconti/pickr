import 'package:pickr/classes/card.dart';
import 'package:pickr/classes/games/game.dart';
import 'package:pickr/enums/suits.dart';
import 'package:pickr/exceptions/out_of_bound_exception.dart';

import '../player.dart';

class Briscola extends Game {
  //
  final int _numcards = 3;
  final int _numplayers = 4;

  Suit _briscola;

  Briscola();

  @override
  void spread() {
    players.forEach((player) {
      player.hand = deck.picks(_numcards);
    });
  }

  @override
  void start() {
    //
    deck.init();

    deck.shuffle();

    _briscola = deck.cards.last.suit;

    spread();
  }

  @override
  GamingCard rule() {
    var winningCard = table.first;

    // assert(this.table.size() == this.numplayers);
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

    print(winningCard.toString());
    return winningCard;
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
  void gameround() {
    players.forEach((player) {
      dropCard(card: player.drop());
    });

    var winningCard = rule();

    winner(winningCard);

    if (cards.length > _numplayers) {
      players.forEach((player) {
        player.pick(deck.pick());
      });
    }
  }
}
