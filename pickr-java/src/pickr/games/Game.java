package pickr.games;


import java.util.ArrayList;

import pickr.classes.Deck;
import pickr.classes.GamingCard;
import pickr.classes.Player;
import pickr.exceptions.OutOfBoundException;
import pickr.exceptions.WrongCardNumberException;

public abstract class Game {
	
	int numplayers;
	int score;
	private int round = 0;
	protected Deck deck;
	private ArrayList<GamingCard> table;
	protected ArrayList<Player> players;
	
	public Game(int numplayers, int score) {
		this.numplayers = numplayers;
		this.score = score;
		this.deck = new Deck();
		this.table = new ArrayList<GamingCard>();
		this.players = new ArrayList<Player>();
	}

	public Deck getDeck() { return deck; }

	public int getRound() { return round; }

	public ArrayList<GamingCard> getTable() { return table; }

	public ArrayList<Player> getPlayers() { return players; }
	
	abstract void spread() throws OutOfBoundException;
	
	abstract GamingCard rule();
	
	public void addPlayer(String id) throws OutOfBoundException {
		if(players.size() < this.numplayers) {
			players.add(new Player(id));
		}
		else throw new OutOfBoundException();
	}
	
	int getTableValue() {
		int result = 0;
		for(GamingCard card : this.table) {
			result += card.getVal();
		}
		return result;
	}
	
	void dropCard(GamingCard card) { table.add(card); }
		
	abstract void start() throws WrongCardNumberException, OutOfBoundException;	
	
	public Player winner(GamingCard winnerCard) {		
		
		Player winner = this.players.get(0);
		
		for(Player player : this.players) {
				
			if(player.getCards().contains(winnerCard)) winner = player;
			
			player.delete();
		}
		
		System.out.println("the winner is " + winner.getId());	
		
		winner.setGameScore(getTableValue());
		
		table.clear();
		
		this.round += 1;
		
		return winner;		
	}

}
