package pickr;

import pickr.classes.Deck;
import pickr.exception.WrongCardNumberException;

public class Main {

	public static void main(String[] args) throws WrongCardNumberException {
			
		Deck deck = new Deck();
		
		deck.init();	
		deck.shuffle();
		// deck.show();
		
	}

}
