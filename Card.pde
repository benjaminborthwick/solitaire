public class Card {
  private Suit suit;
  private int id;
  private String value;
  private int xpos, ypos;
  private boolean facedown;
  
  public Card(int id) {
    this(id, 0, 0, true);
  }
  
  public Card(int id, int xpos, int ypos, boolean facedown) {
    this.id = id;
    switch (id % 13 + 1) {
      case 1:
      this.value = "A";
      break;
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
      case 8:
      case 9:
      case 10:
      this.value = String.valueOf(id % 13 + 1);
      break;
      case 11:
      this.value = "J";
      break;
      case 12:
      this.value = "Q";
      break;
      case 13:
      this.value = "K";
      break;
    }
    switch (id / 13 % 4) {
      case 0:
      this.suit = Suit.HEARTS;
      break;
      case 1:
      this.suit = Suit.SPADES;
      break;
      case 2:
      this.suit = Suit.DIAMONDS;
      break;
      case 3:
      this.suit = Suit.CLUBS;
      break;
    }
    this.xpos = xpos;
    this.ypos = ypos;
    this.facedown = facedown;
  }
  
  public void flip() {
    facedown = facedown == false ? true : false;
  }
  
  public void changepos(int xpos, int ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
  }
  
  public void draw() {
    stroke(0);
    strokeWeight(1);
    if (facedown) {
      fill(220, 20, 20);
      rect(xpos, ypos, 50, 75, 7);
      return;
    }
    fill(255);
    rect(xpos, ypos, 50, 75, 7);
    switch (suit) {
      case HEARTS:
      drawHeart(xpos + 5, ypos + 30);
      break;
      case SPADES:
      drawSpade(xpos + 5, ypos + 30);
      break;
      case DIAMONDS:
      drawDiamond(xpos + 5, ypos + 30);
      break;
      case CLUBS:
      drawClub(xpos + 5, ypos + 30);
    }
    textSize(23);
    text(value, xpos + 4, ypos + 18);
  }
  
  public void drawHeart(int posx, int posy) {
    smooth();
    noStroke();
    fill(255,0,0);
    beginShape();
    vertex(20 + posx, 15 + posy);
    bezierVertex(20 + posx, -5 + posy, 60 + posx, 5 + posy, 20 + posx, 40 + posy);
    vertex(20 + posx, 15 + posy);
    bezierVertex(20 + posx, -5 + posy, -20 + posx, 5 + posy, 20 + posx, 40 + posy);
    endShape();
    scale(0.5);
    posx += 22;
    posy -= 29;
    beginShape();
    vertex(20 + 2*posx, 15 + 2*posy);
    bezierVertex(20 + 2*posx, -5 + 2*posy, 60 + 2*posx, 5 + 2*posy, 20 + 2*posx, 40 + 2*posy);
    vertex(20 + 2*posx, 15 + 2*posy);
    bezierVertex(20 + 2*posx, -5 + 2*posy, -20 + 2*posx, 5 + 2*posy, 20 + 2*posx, 40 + 2*posy);
    endShape();
    scale(2);
  }

  public void drawSpade(int posx, int posy) {
    smooth();
    noStroke();
    fill(0, 0, 0);
    beginShape();
    vertex(20 + posx, posy);
    bezierVertex(35 + posx, 20 + posy, 40 + posx, 32 + posy, 22 + posx, 28 + posy);
    bezierVertex(24 + posx, 35 + posy, 27 + posx, 37 + posy, 30 + posx, 40 + posy);
    vertex(10 + posx, 40 + posy);
    bezierVertex(13 + posx, 37 + posy, 16 + posx, 35 + posy, 18 + posx, 28 + posy);
    bezierVertex(0 + posx, 32 + posy, 5 + posx, 20 + posy, 20 + posx, posy);
    endShape();
    scale(0.5);
    posx += 22;
    posy -= 29;
    beginShape();
    vertex(20 + 2 * posx, 2 * posy);
    bezierVertex(35 + 2 * posx, 20 + 2 * posy, 40 + 2 * posx, 32 + 2 * posy, 22 + 2 * posx, 28 + 2 * posy);
    bezierVertex(24 + 2 * posx, 35 + 2 * posy, 27 + 2 * posx, 37 + 2 * posy, 30 + 2 * posx, 40 + 2 * posy);
    vertex(10 + 2 * posx, 40 + 2 * posy);
    bezierVertex(13 + 2 * posx, 37 + 2 * posy, 16 + 2 * posx, 35 + 2 * posy, 18 + 2 * posx, 28 + 2 * posy);
    bezierVertex(0 + 2 * posx, 32 + 2 * posy, 5 + 2 * posx, 20 + 2 * posy, 20 + 2 * posx, 2 * posy);
    endShape();
    scale(2);
  }
  
  public void drawDiamond(int posx, int posy) {
    smooth();
    noStroke();
    fill(255, 0, 0);
    beginShape();
    vertex(20 + posx, 40 + posy);
    vertex(10 + posx, 20 + posy);
    vertex(20 + posx, 0 + posy);
    vertex(30 + posx, 20 + posy);
    vertex(20 + posx, 40 + posy);
    endShape();
    scale(0.5);
    posx += 22;
    posy -= 29;
    beginShape();
    vertex(20 + 2 * posx, 40 + 2 * posy);
    vertex(10 + 2 * posx, 20 + 2 * posy);
    vertex(20 + 2 * posx, 0 + 2 * posy);
    vertex(30 + 2 * posx, 20 + 2 * posy);
    vertex(20 + 2 * posx, 40 + 2 * posy);
    endShape();
    scale(2);
  }
  
  public void drawClub(int posx, int posy) {
    smooth();
    noStroke();
    fill(0, 0, 0);
    beginShape();
    vertex(21 + posx, 24 + posy);
    bezierVertex(22 + posx, 35 + posy, 24 + posx, 37 + posy, 26 + posx, 40 + posy);
    vertex(14 + posx, 40 + posy);
    bezierVertex(16 + posx, 37 + posy, 18 + posx, 35 + posy, 19 + posx, 24 + posy);
    endShape();
    circle(11 + posx, 23 + posy, 17);
    circle(20 + posx, 10 + posy, 17);
    circle(29 + posx, 23 + posy, 17);
    circle(20 + posx, 20 + posy, 9);
    scale(0.5);
    posx += 22;
    posy -= 29;
    beginShape();
    vertex(21 + 2 * posx, 24 + 2 * posy);
    bezierVertex(22 + 2 * posx, 35 + 2 * posy, 24 + 2 * posx, 37 + 2 * posy, 26 + 2 * posx, 40 + 2 * posy);
    vertex(14 + 2 * posx, 40 + 2 * posy);
    bezierVertex(16 + 2 * posx, 37 + 2 * posy, 18 + 2 * posx, 35 + 2 * posy, 19 + 2 * posx, 24 + 2 * posy);
    endShape();
    circle(11 + 2 * posx, 23 + 2 * posy, 17);
    circle(20 + 2 * posx, 10 + 2 * posy, 17);
    circle(29 + 2 * posx, 23 + 2 * posy, 17);
    circle(20 + 2 * posx, 20 + 2 * posy, 9);
    scale(2);
  }
  
  public String getValue() {
    return value;
  }
  
  public int getNumericValue() {
    return id % 13 + 1;
  }
  
  public Suit getSuit() {
    return suit;
  }
}
