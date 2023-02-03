public boolean swapValid(Pile source, Pile dest) {
  return dest.size() == 0 || source.top().getNumericValue() - 1 + source.getSelectedNum() == dest.top().getNumericValue() - 1;
}

public void swap(Pile source, Pile dest, int num, boolean undo, boolean undoFlip) {
  System.out.println(num);
  if (undoFlip) dest.top().turnFaceDown();
  for (int i = num - 1; i >= 0; i--) {
    if (source.size() > 0) dest.placeCard(source.cards.remove(i));
    else System.out.println("ERROR");
  }
  selected = null;
  if (!undo) new Action(source, dest, num, source.size() > 0 ? source.top().turnFaceUp() : false);
  source.checkTopChunk();
  if (dest.getTopChunk() == 13) {
    new AscendPile(50 + completed.size() * 75, 50, dest);
    new Action(dest, dest.size() > 0 ? dest.top().turnFaceUp() : false);
  }
}

public void swap(Pile source, Pile dest, int num) {
  swap(source, dest, num, false, false);
}

public void swap(Pile source, Pile dest, int num, boolean undoFlip) {
  swap(source, dest, num, true, undoFlip);
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
    if (size() != 0 && card.getSuit() == topSuit && top().getNumericValue() == card.getNumericValue() + 1) topChunk++;
    else {
      topChunk = 1;
      topSuit = card.getSuit();
    }
    cards.addFirst(card);
  }
  
  public int checkTopChunk() {
    int chunkNum;
    if (size() == 0) {
      topSuit = null;
      topChunk = 0;
      return 0;
    }
    topChunk = 1;
    chunkNum = top().getNumericValue();
    topSuit = top().getSuit();
    for (int i = 1; i < cards.size(); i++) {
      if (cards.get(i).isFaceUp() && cards.get(i).getSuit() == topSuit && cards.get(i).getNumericValue() == chunkNum + 1) {
        topChunk++;
        chunkNum++;
      }
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
      System.out.println(topChunk);
      selectedNum = min(topChunk, max(cards.size() - (mouseY - posy) / 23, 1));
      System.out.println("num: " + selectedNum);
    }
    trySwap();
  }
  
  public void trySwap() {
    if (selected == this) {
      glow(230, 230, 60, selectedNum);
      if (mouseClicked) selected = null;
    } else if (selected == null) {
      glow(230, 230, 60, selectedNum);
      if (mouseClicked && size() > 0) selected = this;
    } else {
      System.out.println(getSelectedNum());
      if (swapValid(selected, this)) {
        glow(60, 190, 60, cards.size());
        if (mouseClicked) swap(selected, this, selected.getSelectedNum());
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
