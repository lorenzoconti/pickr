package pickr.classes;


import java.util.ArrayList;
//import java.util.Collections;
import java.util.Collections;

import pickr.enums.Suit;
import pickr.exceptions.OutOfBoundException;
import pickr.exceptions.WrongCardNumberException;

public class Deck {

	public ArrayList<GamingCard> cards;


	public Deck() { this.cards = new ArrayList<GamingCard>();	}

	public ArrayList<GamingCard> getCards() { return cards;	}

	public void init() throws WrongCardNumberException {
		for(int num = 1; num < 11; num++) {
			for(Suit suit : Suit.values()) {
				cards.add(new GamingCard(suit, num));
			}
		}
	}

	public void shuffle() { Collections.shuffle(cards);	}

	public GamingCard pick() throws OutOfBoundException {

		if(!cards.isEmpty())
			return cards.remove(0);
		else throw new OutOfBoundException();

	}

	public ArrayList<GamingCard> picks(int n) throws OutOfBoundException {

		if(cards.size() >= n) {
			ArrayList<GamingCard> picked = new ArrayList<GamingCard>();
			for(int i =0; i < n; i ++) {
				picked.add(cards.remove(0));
			}
			return picked;
		}
		else throw new OutOfBoundException();
	}
}
