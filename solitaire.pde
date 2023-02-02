import java.util.LinkedList;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

static boolean mouseClicked;
static boolean prevPressed;
static int[] deck;
static int size = 104;
static Pile[] piles = new Pile[10];
public static Pile selected;
void setup() {
  size(800, 600);
  background(20, 150, 70);
  deck = new int[104];
  for (int i = 0; i < 104; i++) {
    deck[i] = i;
  }
  Random rnd = ThreadLocalRandom.current();
  for (int i = 103; i > 0; i--) {
    int index = rnd.nextInt(i + 1);
    // Simple swap
    int temp = deck[index];
    deck[index] = deck[i];
    deck[i] = temp;
  }
  for (int i = 0; i < 10; i++) {
    piles[i] = new Pile(50 + i * 70, 150, this);
  }
  for (int i = 0; i < 54; i++) {
    piles[i % 10].deal(i < 44);
  }
  initMoveHist();
}

int glowpile = 0;
boolean newDeal = false;

void draw() {
  if (!prevPressed && mousePressed) mouseClicked = true;
  else mouseClicked = false;
  prevPressed = mousePressed;
  background(20, 150, 70);
  stroke(0);
  strokeWeight(1);
  fill(220, 20, 20);
  for (int i = 0; i < size / 10; i++) {
    rect(600 + 10 * i, 50, 50, 75, 7);
  }
  if (mouseX > 595 && mouseX < 655 + (size / 10) * 10 && mouseY > 45 && mouseY < 130) {
    noFill();
    stroke(230, 230, 60);
    strokeWeight(5);
    rect(597, 46, 45 + (size / 10) * 10, 80);
    if (mouseClicked) {
      newDeal = true;
      new Action();
    } 
  }
  for (Pile pile: piles) {
    if (newDeal) {
      pile.deal(false);
    }
    pile.draw();
    pile.checkGlow();
  }
  newDeal = false;
  fill(220, 20, 20);
  noStroke();
  rect(715, 515, 40, 20);
  triangle(695, 525, 715, 505, 715, 545);
  if (mouseX > 700 && mouseX < 750 && mouseY > 500 && mouseY < 550) {
    noFill();
    stroke(230, 230, 60);
    strokeWeight(5);
    rect(695, 505, 60, 40);
    if (mouseClicked) undoLastAction();
  }
}

Card deal(int posx, int posy, boolean facedown) {
  Card card;
  if (size == 0) {
    System.out.println("Deck is empty; can not deal");
    return null;
  } else {
    card = new Card(deck[size-- - 1], posx, posy, facedown);
    card.draw();
  }
  return card;
}
