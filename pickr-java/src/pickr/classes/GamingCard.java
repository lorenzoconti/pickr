package pickr.classes;

import pickr.enums.Suit;
import pickr.exception.WrongCardNumberException;

public class GamingCard {
	
	private Suit suit;
	private int num;
	private int val;
	
	public GamingCard(Suit suit, int num) throws WrongCardNumberException {
		this.suit = suit;
		this.val = numToVal(num);
		this.num = checkNum(num);
	}
	
	public Suit getSuit() { return this.suit; }
	public int getNum() { return this.num; }
	public int getVal() { return this.val; }
	
	
	int numToVal(int num) {
		if(num != 1 && num != 3) return num-1;
		else return num == 1 ? 10 : 9;		
	}
	
	  int checkNum(int num) throws WrongCardNumberException {
		    if (num < 1 || num > 10) {
		      throw new WrongCardNumberException();
		    }
		    return num;
	  }
	  
	  @Override
	public String toString() {	return num + " " + suit.toString() + " value: " + val;	}

}
