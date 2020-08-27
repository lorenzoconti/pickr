package pickr.classes;


import java.util.ArrayList;

public class Player {
	
	// @ spec_public
	private ArrayList<GamingCard> cards;
	
	// @ spec_public
	private String id;
	
	// @ spec_public
	private int gameScore;
	
	// @ spec_public
	private int matchScore;
	
	public Player(String id) {
		this.id = id;
		this.cards = new ArrayList<GamingCard>();
		this.gameScore = 0;
		this.matchScore = 0;
	}

	
	public ArrayList<GamingCard> getCards() { return cards;	}

	public void hand(ArrayList<GamingCard> cards) { this.cards = cards;	}
	
	// @ ensures this.cards.size() == \old(this.cards.size()) ;
	public GamingCard drop() { return this.cards.get(0); }

	// @ ensures \result == this.gameScore ;
	public int getGameScore() {	return gameScore; }

	// @ requires gameScore >= 0 ;
	// @ ensures this.gameScore == \old(this.gameScore) + gameScore ;
	public void setGameScore(int gameScore) { this.gameScore += gameScore;	}

	// @ ensures \result == this.matchScore ;
	public int getMatchScore() { return matchScore; }

	// @ ensures this.matchScore == \old(this.matchScore) + matchScore ;
	public void setMatchScore(int matchScore) {	this.matchScore = matchScore; }

	// @ ensures \result == this.id ;
	public String getId() {	return id;	}

	// @ requires cards.size() > 0 ;
	// @ ensures this.cards.size() == \old(this.cards.size()) -1 ;
	public void delete() { this.cards.remove(0); }
	
	// @ ensures cards.size() == \old(cards.size()) + 1 ;
	public void pick(GamingCard card) { this.cards.add(card);  }

}

