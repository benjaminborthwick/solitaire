import java.util.Stack; 
private static Stack<Action> moveHist;

public static void undoLastAction() {
  if (moveHist.empty()) return;
  moveHist.pop().undo();
}

public static void initMoveHist() {
  moveHist = new Stack();
}
  
public class Action {
  //0 = move
  //1 = deal
  //2 = ascend
  private int type;
  private Pile source;
  private Pile dest;
  private int num;
  private boolean cardFlipped;
  
  public Action(Pile source, Pile dest, int num, boolean cardFlipped) {
    this.type = 0;
    this.source = source;
    this.dest = dest;
    this.num = num;
    this.cardFlipped = cardFlipped;
    moveHist.push(this);
  }
  
  public Action() {
    this.type = 1;
    moveHist.push(this);
  }
  
  public Action(Pile source, boolean cardFlipped) {
    this.type = 2;
    this.source = source;
    this.cardFlipped = cardFlipped;
    moveHist.push(this);
  }
  
  public void undo() {
    if (this.type == 0) undoMove();
    if (this.type == 1) undoDeal();
    if (this.type == 2) undoAscend();
  }
  
  public void undoMove() {
    swap(dest, source, num, cardFlipped);
  }
  
  public void undoDeal() {
    for (int i = 9; i >= 0; i--) {
      deck[size++] = piles[i].pop().getId();
      piles[i].checkTopChunk();
    }
  }
  
  public void undoAscend() {
    if (source.size() != 0 && cardFlipped) source.top().turnFaceUp();
    Card[] cards = completed.pop().getCards();
    for (int i = 12; i >= 0; i--) {
      source.placeCard(cards[i]);
    }
    undo();
  }
}
