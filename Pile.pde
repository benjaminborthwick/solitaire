public class Pile {
  private LinkedList<Card> cards;
  int posx;
  int posy;
  solitaire main;
  
  public Pile(int posx, int posy, solitaire main) {
    cards = new LinkedList<Card>();
    this.posx = posx;
    this.posy = posy;
    this.main = main;
  }
  
  public void deal(boolean facedown) {
    cards.addFirst(main.deal(posx, posy + cards.size() * 23, facedown));
  }
  
  public void placeCard(Card card) {
    card.changepos(posx, cards.size() * 23);
    cards.addFirst(card);
  }
  
  public void checkGlow() {
    if (mouseX < posx - 5 || mouseX > posx + 55 || mouseY < posy - 5 || mouseY > posy + cards.size() * 23 + 57) {
      if (selected == this) glow(230, 230, 60);
      return;
    }
    trySwap();
  }
  
  public void trySwap() {
    if (selected == this) {
      glow(230, 230, 60);
      if (mouseClicked) selected = null;
    } else if (selected == null) {
      glow(230, 230, 60);
      if (mouseClicked) selected = this;
    } else {
      if (mouseClicked) {
        if (swapValid(selected.top(), top())) swap(selected, this);
        else {
          glow(200, 70, 70);
          return;
        }
      }
      glow(60, 190, 60);
    }
  }
  
  public boolean swapValid(Card source, Card dest) {
    return source.getNumericValue() == dest.getNumericValue() + 1;
  }
  
  public void swap(Pile source, Pile dest) {
    dest.placeCard(source.cards.remove());
    source.top().flip();
  }
  
  public void glow(int R, int G, int B) {
    noFill();
    stroke(R, G, B);
    strokeWeight(5);
    rect(posx - 3, posy - 3, 55, cards.size() * 23 + 57);
  }
  
  public void draw() {
    for (int i = cards.size() - 1; i >= 0; i--) {
      cards.get(i).draw();
    }
  }
  
  public boolean equals(Object o) {
    if (!(o instanceof Pile)) return false;
    if (((Pile)o).posx == posx && ((Pile)o).posy == posy) return true;
    return false;
  }
  
  public int size() {
    return cards.size();
  }
  
  public Card top() {
    return cards.get(0);
  }
}
