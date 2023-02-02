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
  
  public Action(Pile source) {
    this.type = 2;
    this.source = source;
    moveHist.push(this);
  }
  
  public void undo() {
    if (this.type == 0) undoMove();
    if (this.type == 1) undoDeal();
    if (this.type == 2) undoAscend();
  }
  
  public void undoMove() {
    dest.setSelectedNum(num);
    swap(dest, source, cardFlipped);
    
  }
  
  public void undoDeal() {
    
  }
  
  public void undoAscend() {
    
  }
}
