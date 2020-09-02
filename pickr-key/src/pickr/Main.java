package pickr;

public class Main {

	public static void main(String[] args) throws WrongNumberException  {
		
		CardDBC card = new CardDBC(Suit.BASTONI, 10);
		
		DeckDBC deck = new DeckDBC();
		
		deck.init();

		
	}

}
