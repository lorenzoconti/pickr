package pickr.classes;


import java.util.ArrayList;

public class Player {
	
	private ArrayList<GamingCard> cards;
	
	private String id;
	
	private int gameScore;
	
	private int matchScore;
	
	public Player(String id) {
		this.id = id;
		this.cards = new ArrayList<GamingCard>();
		this.gameScore = 0;
		this.matchScore = 0;
	}

	
	public ArrayList<GamingCard> getCards() { return cards;	}

	public void hand(ArrayList<GamingCard> cards) { this.cards = cards;	}
	
	public GamingCard drop() { return this.cards.get(0); }

	public int getGameScore() {	return gameScore; }

	public void setGameScore(int gameScore) { this.gameScore += gameScore;	}

	public int getMatchScore() { return matchScore; }

	public void setMatchScore(int matchScore) {	this.matchScore = matchScore; }

	public String getId() {	return id;	}

	public void delete() { this.cards.remove(0); }
	
	public void pick(GamingCard card) { this.cards.add(card);  }

}

