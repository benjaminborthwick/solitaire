import java.util.LinkedList;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

static boolean mouseClicked;
static boolean prevPressed;
static int[] deck;
static int size = 104;
static Pile[] piles = new Pile[10];
static Pile selected;
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
  for (int i = 0; i < 64; i++) {
    piles[i % 10].deal(i < 54);
  }
}

int glowpile = 0;

void draw() {
  if (!prevPressed && mousePressed) mouseClicked = true;
  else mouseClicked = false;
  prevPressed = mousePressed;
  background(20, 150, 70);
  for (Pile pile: piles) {
    pile.draw();
    pile.checkGlow();
  }
  System.out.println(frameRate);
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
