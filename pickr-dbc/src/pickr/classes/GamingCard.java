package pickr.classes;

import pickr.enums.Suit;
import pickr.exceptions.WrongCardNumberException;

public class GamingCard {
	
	private Suit suit;
	private int num;
	private int val;
	
	public GamingCard(Suit suit, int num) throws WrongCardNumberException {
	
		this.suit = suit;
		this.val = numToVal(num);
		this.num = checkNum(num);
	}
	
	// @ ensures \result == this.suit ;
	public Suit getSuit() { return this.suit; }
	
	// @ ensures \result == this.num ;
	public int getNum() { return this.num; }
	
	// @ ensures \result == this.val ;
	public int getVal() { return this.val; }
	
	
	// @ requires num > 0 && num < 11 ;
	// @ ensures \result > 0 && \result < 11 ;
	int numToVal(int num) {
		if(num != 1 && num != 3) return num-1;
		else return num == 1 ? 10 : 9;		
	}
	
	// @ requires num > 0 && num < 11 ;
	// @ ensures \result > 0 && \result < 11 ;
	int checkNum(int num) throws WrongCardNumberException {
	 
		    if (num < 1 || num > 10) {
		      throw new WrongCardNumberException();
		    }
		    return num;
	 }
	
	@Override
	public String toString() {	return num + " " + suit.toString() + " value: " + val;	}

}
