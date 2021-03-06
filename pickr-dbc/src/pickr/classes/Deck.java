package pickr.classes;


import java.util.ArrayList;
//import java.util.Collections;

import pickr.enums.Suit;
import pickr.exceptions.OutOfBoundException;
import pickr.exceptions.WrongCardNumberException;

public class Deck {
	
	public ArrayList<GamingCard> cards;
	
	//@ public invariant this.cards != null ;
	//@ public invariant this.cards.size() <= 40 ;
	
	public Deck() { this.cards = new ArrayList<GamingCard>();	}

	public ArrayList<GamingCard> getCards() { return cards;	}
	
	//@ requires this.cards.size() == 0 ;
	//@ ensures this.cards.size() == 40 ;
	public void init() throws WrongCardNumberException {
		for(int num = 1; num < 11; num++) {
			for(int i=0; i < 4; i++) {
				switch(i) {
					case 0: cards.add(new GamingCard(Suit.COPPE, num)); break;
					case 1: cards.add(new GamingCard(Suit.BASTONI, num)); break;
					case 2: cards.add(new GamingCard(Suit.SPADE, num)); break;
					case 3: cards.add(new GamingCard(Suit.ORI, num)); break;
				}
			}			
		}
	}
	
	//@ normal_behavior
	//@ requires !this.cards.isEmpty();
	//@ ensures cards.size() == \old(cards.size()) ;
	//@ ensures \result != null;
	//@ also
	//@ exceptional_behavior
	//@ requires this.cards.isEmpty();
	//@ signals (Exception e) e instanceof OutOfBoundException;
	public GamingCard pick() throws OutOfBoundException {
	
		if(!cards.isEmpty()) 
			return cards.remove(0);
		else throw new OutOfBoundException();
	
	}
	
	//@ requires n > 0 ;
	//@ ensures cards.size() == \old(cards.size()) - n ;
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
