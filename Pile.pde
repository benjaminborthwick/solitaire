public class Pile {
  LinkedList<Card> cards;
  PGraphics pg;
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
  
  public void glow() {
    pg = createGraphics(800, 600);
    pg.beginDraw();
    pg.noFill();
    pg.stroke(200, 200, 30);
    pg.strokeWeight(5);
    pg.rect(posx - 3, posy - 3, 55, cards.size() * 23 + 57);
    pg.filter(BLUR, 2);
    pg.endDraw();
    image(pg, 0, 0);
    blend(pg, 8, 8, 800, 600, 6, 6, 800, 600, ADD);
  }
  
  public void draw() {
    for (int i = cards.size() - 1; i >= 0; i--) {
      cards.get(i).draw();
    }
  }
}
