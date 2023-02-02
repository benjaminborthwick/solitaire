public boolean swapValid(Pile source, Pile dest) {
  return source.top().getNumericValue() - 1 + source.getSelectedNum() == dest.top().getNumericValue() - 1 || dest.size() == 0;
}

public void swap(Pile source, Pile dest, boolean undo, boolean undoFlip) {
  if (undoFlip) dest.top().turnFaceDown();
  for (int i = source.getSelectedNum() - 1; i >= 0; i--) {
    dest.placeCard(source.cards.remove(i));
  }
  selected = null;
  if (!undo) new Action(source, dest, source.getSelectedNum(), source.top().turnFaceUp());
  source.checkTopChunk();
  if (dest.getTopChunk() == 13) {
    dest.ascend();
  }
}

public void swap(Pile source, Pile dest) {
  swap(source, dest, false, false);
}

public void swap(Pile source, Pile dest, boolean undoFlip) {
  swap(source, dest, true, undoFlip);
}

public class Pile {
  private LinkedList<Card> cards;
  int posx;
  int posy;
  int topChunk;
  int selectedNum;
  Suit topSuit;
  solitaire main;
  
  public Pile(int posx, int posy, solitaire main) {
    cards = new LinkedList<Card>();
    this.posx = posx;
    this.posy = posy;
    this.main = main;
  }
  
  public void deal(boolean facedown) {
    cards.addFirst(main.deal(posx, posy + cards.size() * 23, facedown));
    if (!facedown) {
      topChunk = 1;
      topSuit = top().getSuit();
    }
  }
  
  public void placeCard(Card card) {
    card.changepos(posx, posy + cards.size() * 23);
    cards.addFirst(card);
    if (card.getSuit() == topSuit) topChunk++;
    else {
      topChunk = 1;
      topSuit = card.getSuit();
    }
  }
  
  public int checkTopChunk() {
    topChunk = 1;
    topSuit = top().getSuit();
    for (int i = 1; i < cards.size(); i++) {
      if (cards.get(i).isFaceUp() && cards.get(i).getSuit() == topSuit) topChunk++;
      else break;
    }
    return topChunk;
  }
  
  public void checkGlow() {
    if (mouseX < posx - 5 || mouseX > posx + 55 || mouseY < posy - 5 || mouseY > posy + cards.size() * 23 + 57) {
      if (selected == this) glow(230, 230, 60, selectedNum);
      return;
    }
    if (selected != this) {
      selectedNum = min(topChunk, max(cards.size() - (mouseY - posy) / 23, 1));
    }
    trySwap();
    System.out.println(topChunk);
  }
  
  public void trySwap() {
    if (selected == this) {
      glow(230, 230, 60, selectedNum);
      if (mouseClicked) selected = null;
    } else if (selected == null) {
      glow(230, 230, 60, selectedNum);
      if (mouseClicked) selected = this;
    } else {
      if (swapValid(selected, this)) {
        glow(60, 190, 60, cards.size());
        if (mouseClicked) swap(selected, this);
      } else {
        glow(230, 40, 40, cards.size());  
      }
    }
  }
  
  public void glow(int R, int G, int B, int num) {
    noFill();
    stroke(R, G, B);
    strokeWeight(5);
    rect(posx - 3, posy - 3 + (cards.size() - num) * 23, 55, num * 23 + 57);
  }
  
  public void ascend() {
    //dosomething
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
  
  public Card pop() {
    return cards.remove();
  }
  
  public Card top() {
    return cards.get(0);
  }
  
  public int getTopChunk() {
    return topChunk;
  }
  
  public int getSelectedNum() {
    return selectedNum;
  }
  
  public void setSelectedNum(int num) {
    selectedNum = num;
  }
}
