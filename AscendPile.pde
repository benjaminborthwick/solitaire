public class AscendPile {
  int posx;
  int posy;
  Card[] cards;
  
  public AscendPile(int posx, int posy, Pile source) {
    cards = new Card[13];
    for (int i = 0; i < 13; i++) {
      cards[i] = source.pop();
    }
    cards[0].changepos(posx, posy);
    completed.push(this);
    score += 101;
  }
  
  public void draw() {
    cards[0].draw();
  }
  
  public Card[] getCards() {
    return cards;
  }
}
