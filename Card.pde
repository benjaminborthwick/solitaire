public class Card {
  private Suit suit;
  private String value;
  private int xpos, ypos;
  
  public Card(Suit suit, String value) {
    this(suit, value, 0, 0);
  }
  
  public Card(Suit suit, String value, int xpos, int ypos) {
    this.suit = suit;
    this.value = value;
    this.xpos = xpos;
    this.ypos = ypos;
  }
  
  public void changepos(int xpos, int ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
  }
  
  public void draw() {
    fill(255);
    rect(xpos, ypos, 50, 75, 7);
    switch (suit) {
      case HEARTS:
      drawHeart(xpos + 5, ypos + 30);
      break;
      
    }
    textSize(32);
    text(value, xpos + 15, ypos + 25);
  }
}
