import java.util.LinkedList;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

static boolean mouseClicked;
static boolean prevPressed;
static int[] deck;
static int size;
static Pile[] piles;
public static Pile selected;
static Stack<AscendPile> completed;
static int score;
boolean gameWon;
void setup() {
  size(800, 800);
  background(20, 150, 70);
  gameWon = false;
  size = 104;
  score = 800;
  piles = new Pile[10];
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
  completed = new Stack<AscendPile>();
}

int glowpile = 0;
boolean newDeal = false;

void draw() {
  background(20, 150, 70);
  if (!prevPressed && mousePressed) mouseClicked = true;
  else mouseClicked = false;
  prevPressed = mousePressed;
  if (gameWon) winGame();
  else playGame();
  
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

void playGame() {
  stroke(0);
  strokeWeight(1);
  fill(220, 20, 20);
  for (int i = 0; i < size / 10; i++) {
    rect(600 + 10 * i, 50, 50, 75, 7);
  }
  if (size > 0 && mouseX > 595 && mouseX < 655 + (size / 10) * 10 && mouseY > 45 && mouseY < 130) {
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
      pile.checkTopChunk();
    }
    pile.draw();
    pile.checkGlow();
  }
  newDeal = false;
  fill(255);
  textSize(32);
  text("Score: " + String.valueOf(score), 300, 40);
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
  for (AscendPile ascended : completed) {
    ascended.draw();
  }
}

void winGame() {
  if (!gameWon) gameWon = true;
  fill(220, 220, 20);
  textSize(180);
  text("You Win!", 100, 300);
  fill(255);
  textSize(64);
  text("Score: " + String.valueOf(score), 270, 450);
  noStroke();
  rect(340, 520, 135, 50, 5);
  fill(0);
  textSize(28);
  text("Play Again", 347, 555);
  if (mouseX > 335 && mouseX < 480 && mouseY > 515 && mouseY < 575) {
    stroke(220, 220, 20);
    strokeWeight(5);
    noFill();
    rect(337, 518, 140, 54);
    if (mouseClicked) setup();
  }
}
