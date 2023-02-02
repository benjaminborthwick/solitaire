void setup() {
  size(600, 600);
  background(20, 150, 70);
}

void draw() {
  Card card = new Card(Suit.SPADES, "2", 20, 20);
  card.draw();
}
