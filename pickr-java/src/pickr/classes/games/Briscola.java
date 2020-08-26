package pickr.classes.games;

import pickr.classes.GamingCard;
import pickr.classes.Player;
import pickr.enums.Suit;
import pickr.exception.OutOfBoundException;
import pickr.exception.WrongCardNumberException;

public class Briscola extends Game{
	
	private int numcards = 3;
	
	private Suit briscola;
	
	public Briscola(int numplayers, int score) {
		super(numplayers, score);
	}
	

	@Override
	void spread() throws OutOfBoundException {
		for(Player player : players) {
			player.hand(deck.picks(numcards));
		}		
	}

	@Override
	public void start() throws WrongCardNumberException, OutOfBoundException { 	
		
		this.deck.init();
		this.deck.shuffle();
		
		briscola = deck.getCards().get(deck.getCards().size()-1).getSuit();
		
		this.spread();
		
		// this.deck.show();
	}


	@Override
	GamingCard rule() {
		
		GamingCard winningCard = this.getTable().get(0);
		
		// assert(this.getTable().size() == this.numplayers);
		for(GamingCard card : this.getTable()) {			
			
			if(card.getVal() > winningCard.getVal()) {
				// T T T
				if(winningCard.getSuit() == briscola && card.getSuit() == briscola) {
					winningCard = card;
				}
				// T F F 
				if(winningCard.getSuit() != briscola && card.getSuit() != briscola) {
					winningCard = card;
				}
			}
			// F T F 
			else if(card.getSuit() == briscola && winningCard.getSuit() != briscola) {
				winningCard = card;
			}			
		}
		
		System.out.println("Briscola.rule() : " + winningCard);
				
		return winningCard;
	}
	



	public void round() throws OutOfBoundException {
		
		System.out.println("Briscola.round() : " + briscola.toString());
		
		for(Player player : this.players) {
			this.dropCard(player.drop());
		}
		
		System.out.println("Briscola.round() : " + this.getTable());
		
		GamingCard winningCard = this.rule();
		
		this.winner(winningCard);	
		
		for(Player player : this.players) {
			player.pick(this.deck.pick());
		}		
	}
}
