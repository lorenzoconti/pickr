package pickr;


import java.util.ArrayList;
//import java.util.Collections;

public class DeckDBC {
	
	// @ spec_public
	public ArrayList<CardDBC> cards;
	
	// @ invariant this.cards != null ;
	// @ invariant this.cards.size() <= 40
	
	public DeckDBC() { this.cards = new ArrayList<CardDBC>();	}

	public ArrayList<CardDBC> getCards() { return cards;	}
	
	// @ requires this.cards.size() == 0 ;
	// @ ensures this.cards.size() == 40 ;
	public void init() {
		for(int num = 1; num < 11; num++) {
			for(int i=0; i < 4; i++) {
				switch(i) {
					case 0: cards.add(new CardDBC(Suit.COPPE, num)); break;
					case 1: cards.add(new CardDBC(Suit.BASTONI, num)); break;
					case 2: cards.add(new CardDBC(Suit.SPADE, num)); break;
					case 3: cards.add(new GamingCard(Suit.ORI, num)); break;
				}
			}			
		}
	}
	
	// @ requires cards.size() > 0 ;
	// @ ensures \old(cards.size()) == cards.size() ;
	// @ public void shuffle() { Collections.shuffle(cards);	}
	
	// @ ensure cards.size() == \old(cards.size()) ;
	public GamingCard pick() throws OutOfBoundException {
	
		if(!cards.isEmpty()) 
			return cards.remove(0);
		else throw new OutOfBoundException();
	
	}
	
	// @ requires n > 0 ;
	// @ ensures cards.size() == \old(cards.size()) - n ;
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
