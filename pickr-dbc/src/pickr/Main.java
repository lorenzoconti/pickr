package pickr;

import pickr.classes.Deck;
import pickr.classes.GamingCard;
import pickr.classes.Player;
import pickr.enums.Suit;
import pickr.exceptions.WrongCardNumberException;

public class Main {

	public static void main(String[] args) throws WrongCardNumberException  {

		// GAMING CARD
		
		GamingCard card = new GamingCard(Suit.ORI, 10);
		
		System.out.print(card.getNum() + " di " + card.getSuit().toString() + " (" + card.getVal() + ")");
		System.out.print(card.toString());
				
		// DECK
		
		Deck deck = new Deck();
		
		deck.init();
		
		
		// PLAYER
	}

}
