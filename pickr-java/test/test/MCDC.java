package test;

import java.util.ArrayList;

import org.junit.Test;

import pickr.classes.GamingCard;
import pickr.classes.Player;
import pickr.enums.Suit;
import pickr.exceptions.OutOfBoundException;
import pickr.exceptions.WrongCardNumberException;
import pickr.games.Briscola;

class GameMCDC extends Briscola {

	public GameMCDC(int numplayers, int score) { super(numplayers, score);	}
	
	@Override
	public void start() throws WrongCardNumberException, OutOfBoundException {
		
		ArrayList<GamingCard> player1 = new ArrayList<GamingCard>();
		player1.add(new GamingCard(Suit.BASTONI, 2));
		player1.add(new GamingCard(Suit.ORI, 9));		
		this.players.get(0).hand(player1);
		
		ArrayList<GamingCard> player2 = new ArrayList<GamingCard>();
		player2.add(new GamingCard(Suit.BASTONI, 10));
		player2.add(new GamingCard(Suit.ORI, 2));		
		this.players.get(1).hand(player2);
		
		ArrayList<GamingCard> player3 = new ArrayList<GamingCard>();
		player3.add(new GamingCard(Suit.ORI, 3));
		player3.add(new GamingCard(Suit.BASTONI, 4));		
		this.players.get(2).hand(player3);
		
		ArrayList<GamingCard> player4 = new ArrayList<GamingCard>();
		player4.add(new GamingCard(Suit.ORI, 1));
		player4.add(new GamingCard(Suit.SPADE, 6));		
		this.players.get(3).hand(player4);
		
		this.briscola = Suit.ORI;
	}
	
	@Override
	public void round() throws OutOfBoundException {
		
		for(Player player : this.players) {
			this.dropCard(player.drop());
		}
		
		System.out.println("Briscola.round() : " + this.getTable());
		
		GamingCard winningCard =  rule();
		
		this.winner(winningCard);	
	
	}
	
	
}

public class MCDC {
	
	@Test
	public void MCDC_Test() throws OutOfBoundException, WrongCardNumberException { 
		
		int score = 10;
		int numplayers = 4;
		
		GameMCDC game = new GameMCDC(numplayers, score);	
		
		for(int i=0; i < 4; i++) { game.addPlayer("Player " + i); }
		
		game.start();
		
		game.round();
		game.round();
	}

}
