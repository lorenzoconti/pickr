import 'package:pickr/classes/card.dart';
import 'package:pickr/classes/games/game.dart';
import 'package:pickr/enums/suits.dart';
import 'package:pickr/exceptions/out_of_bound_exception.dart';

import '../player.dart';

class Briscola extends Game {
  //
  int _numcards = 3;
  int _numplayers = 4;

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
    GamingCard winningCard = this.table.first;

    // assert(this.table.size() == this.numplayers);
    this.table.forEach((card) {
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
    if (players.length <= _numplayers - 1)
      players.add(Player(id: id));
    else
      throw OutOfBoundException();
  }

  void gameround() {
    players.forEach((player) {
      this.dropCard(card: player.drop());
    });

    GamingCard winningCard = this.rule();

    this.winner(winningCard);

    if (this.cards.length > _numplayers) {
      players.forEach((player) {
        player.pick(this.deck.pick());
      });
    }
  }
}
