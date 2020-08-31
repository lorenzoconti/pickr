package pickr.games;

import pickr.classes.GamingCard;
import pickr.classes.Player;
import pickr.enums.Suit;
import pickr.exceptions.OutOfBoundException;
import pickr.exceptions.WrongCardNumberException;

public class Briscola extends Game{
	
	private int numcards = 3;
	
	protected Suit briscola;
	
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
	protected GamingCard rule() {
		
		GamingCard winningCard = this.getTable().get(0);
		
		for(GamingCard card : this.getTable()) {	
				
			// T T T
			if(card.getVal() > winningCard.getVal() && winningCard.getSuit() == briscola && card.getSuit() == briscola) {
				winningCard = card;
			}
			// T F F 
			if(card.getVal() > winningCard.getVal() && winningCard.getSuit() != briscola && card.getSuit() != briscola) {
				winningCard = card;
			}
			
			// F T F 
			 if(!(card.getVal() > winningCard.getVal()) && card.getSuit() == briscola && winningCard.getSuit() != briscola) {
				winningCard = card;
			}	
			
		}
		return winningCard;
	}
	



	public void round() throws OutOfBoundException {
		
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
