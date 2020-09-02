package pickr;

public class DeckDBC {
	
	public int index = 40;
	
	//@ spec_public
	private CardDBC[] cards;

	public DeckDBC() { this.cards = new CardDBC[40]; }

	public CardDBC[] getCards() { return cards;	}
	
	
	public void init() throws WrongNumberException {
		int ind = 0;
		for(int num = 1; num < 11; num++) {
			for(int i=0; i < 4; i++) {
				switch(i) {
					case 0: cards[ind] = new CardDBC(Suit.BASTONI, num);
					case 1: cards[ind] = new CardDBC(Suit.ORI, num);
					case 2: cards[ind] = new CardDBC(Suit.SPADE, num);
					case 3: cards[ind] = new CardDBC(Suit.COPPE, num);
				}
				ind ++;
			}			
		}
	}
	
	//@ requires index > 0;
	//@ ensures cards.length == \old(cards.length) ;
	//@ ensures index == \old(index)-1 ;
	public CardDBC pick() {
		if(index > 0) {
			CardDBC last = this.cards[index];
			index--;
			return last;
		}
		return null;			
	}
	
	//@ requires n > 0 && n < 6 && index >= n ;
	//@ ensures index >=0 ;
	//@ ensures index == \old(index) - n ;
	public CardDBC[] picks(int n) {	
		
		CardDBC[] picks = new CardDBC[n];
		
		if(index >= n) {
			//@ loop_invariant (index-i-1 >= 0) && picks[i] != null;
			//@ loop_invariant (\forall int j; 0<=j && j<i; picks[j].num != 0);
			for(int i =0; i < n; i ++) {
				picks[i] = this.cards[index-i-1];
			}
			index -= n;
			return picks;			
		}
		else return new CardDBC[n];	
	}	
}
