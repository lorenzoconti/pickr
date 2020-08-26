package pickr.classes.games;

import pickr.classes.GamingCard;
import pickr.classes.Player;
import pickr.enums.Suit;
import pickr.exception.OutOfBoundException;
import pickr.exception.WrongCardNumberException;

public class BriscolaChiamata extends Game {
	
	int numcards = 8;
	
	private Suit briscola;

	public BriscolaChiamata(int numplayers, int score) {
		super(numplayers, score);
	}

	@Override
	void spread() throws OutOfBoundException {
		for(Player player : players) {
			player.hand(deck.picks(numcards));
		}		
		assert(this.deck.getCards().size() == 0);
	}

	@Override
	void start() throws WrongCardNumberException, OutOfBoundException {
		this.deck.init();
		this.deck.shuffle();
		briscola = deck.getCards().get(deck.getCards().size()-1).getSuit();
		this.spread();
		//this.deck.show();
	}

	@Override
	GamingCard rule() {
		
		GamingCard winningCard = this.getTable().get(0);
		
		// assert(this.getTable().size() == this.numplayers);
		for(GamingCard card : this.getTable()) {			
			
			if(card.getVal() > winningCard.getVal()) {
				if(winningCard.getSuit() == briscola && card.getSuit() == briscola) {
					winningCard = card;
				}
				if(winningCard.getSuit() != briscola && card.getSuit() != briscola) {
					winningCard = card;
				}
			}
			else if(card.getSuit() == briscola && winningCard.getSuit() != briscola) {
				winningCard = card;
			}			
		}
				
		return winningCard;
	}
}
