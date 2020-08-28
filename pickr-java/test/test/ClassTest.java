package test;

import static org.junit.Assert.*;


import org.junit.Test;

import pickr.classes.Deck;
import pickr.classes.GamingCard;
import pickr.classes.Player;
import pickr.enums.Suit;
import pickr.exceptions.OutOfBoundException;
import pickr.exceptions.WrongCardNumberException;
import pickr.games.Briscola;

public class ClassTest {
	
	int numcards = 3;
	int score = 10;
	int numplayers = 4;
	
	@Test
	public void testDeck() throws WrongCardNumberException {
		
		Deck deck = new Deck();
		
		assertEquals(deck.getCards().size(), 0);
		
		deck.init();
		
		assertEquals(deck.getCards().size(), 40);
		
		// deck.shuffle();
		
		assertEquals(deck.getCards().size(), 40);		
		
	}
	
	@Test
	public void testBriscola() throws WrongCardNumberException, OutOfBoundException {
		
		Briscola game = new Briscola(numplayers, score);
		
		for(int i=0; i < 4; i++) { game.addPlayer("Player " + i); }
		
		assertEquals(game.getDeck().getCards().size(), 0);
		
		game.start();
		
		int remaining = 40 - numcards*game.getPlayers().size();
		
		assertEquals(game.getDeck().getCards().size(), remaining);
		
		for(Player player : game.getPlayers()) { System.out.println(player.getId() + " " + player.getCards());	}
		
		game.round();			
		
		assertEquals(game.getDeck().getCards().size(), 40 - game.getPlayers().size()*numcards - game.getPlayers().size()*game.getRound());		
	}
	
	@Test(expected = Exception.class)
	public void testGame() throws OutOfBoundException, WrongCardNumberException {
		
		Briscola game = new Briscola(numplayers, score);	
		
		for(int i=0; i < 4; i++) { game.addPlayer("Player " + i); }
		
		game.start();
		
		int remaining = 40 - numcards*game.getPlayers().size();
		
		for(int round = 0; round < remaining/game.getPlayers().size(); round ++) { game.round(); }
		
		assertEquals(game.getDeck().getCards().size(), 0);
		
		game.round();
	}
	
	@Test(expected = Exception.class)
	public void testWrongCardNumberException() throws WrongCardNumberException {
		
		new GamingCard(Suit.BASTONI, 11);			
	}
	
	@Test(expected = Exception.class)
	public void testOutOfBoundException() throws OutOfBoundException {
		
		Deck deck = new Deck();
		deck.picks(10);		
	}
}

