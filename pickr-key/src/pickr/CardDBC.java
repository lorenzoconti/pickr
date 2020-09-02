package pickr;

enum Suit { SPADE, ORI, BASTONI, COPPE }

public class CardDBC {
	
	//@ spec_public
	private Suit suit;
	
	public int num;
	//@ spec_public
	private int val;
	
	public CardDBC(Suit suit, int num) throws WrongNumberException {
	
		this.suit = suit;
		this.val = numToVal(num);
		this.num = checkNum(num);
	}
	
	//@ ensures \result == this.suit ;
	public Suit getSuit() { return this.suit; }
	
	//@ ensures \result == this.num ;
	public int getNum() { return this.num; }
	
	//@ ensures \result == this.val ;
	public int getVal() { return this.val; }
	
	
	//@ requires num > 0 && num < 11 ;
	//@ ensures \result > 0 && \result < 11 ;
	int numToVal(int num) {
		if(num != 1 && num != 3) return num-1;
		else return num == 1 ? 10 : 9;		
	}
	
	public String toString() { return this.num + " di " + this.suit; }
	 
	//@ normal_behavior
	//@ requires num > 0 && num < 11 ;
	//@ ensures \result > 0 && \result < 11 ;
	//@ also
	//@ exceptional_behavior
	//@ requires num<1 || num > 10;
	//@ signals (Exception e) e instanceof WrongNumberException;
	int checkNum(int num) throws WrongNumberException {
	 
		    if (num < 1 || num > 10) {
		    	throw new WrongNumberException();
		    }
		    return num;
	 }
}
